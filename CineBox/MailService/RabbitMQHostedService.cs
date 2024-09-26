using System;
using CineBox.Model.ViewModels;
using EasyNetQ;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace MailService
{
	public class RabbitMQHostedService : BackgroundService
	{
        private readonly ILogger _logger;
        private IConnection _connection;
        private IModel _channel;
        private readonly IEmailSender _emailSender;

        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public RabbitMQHostedService(ILoggerFactory loggerFactory, IEmailSender emailSender)
        {
            _logger = loggerFactory.CreateLogger<RabbitMQHostedService>();
            _emailSender = emailSender;
            InitRabbitMQ();
        }

        private void InitRabbitMQ()
        {
            var factory = new ConnectionFactory
            {
                HostName = _host,
                UserName = _username,
                Password = _password
            };

            // create connection  
            _connection = factory.CreateConnection();

            // create channel  
            _channel = _connection.CreateModel();

            //_channel.ExchangeDeclare("demo.exchange", ExchangeType.Topic);
            _channel.QueueDeclare("Reservation_added", false, false, false, null);
            //_channel.QueueBind("demo.queue.log", "demo.exchange", "demo.queue.*", null);
            _channel.BasicQos(0, 1, false);

            _connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            try
            {
                using (var bus = RabbitHutch.CreateBus($"host={_host};virtualHost={_virtualhost};username={_username};password={_password}"))
                {
                    bus.PubSub.Subscribe<ReservationNotifier>("New_Reservations", HandleMessage);
                    Console.WriteLine("Listening for reservations.");

                    while (!stoppingToken.IsCancellationRequested)
                    {
                        await Task.Delay(TimeSpan.FromSeconds(7), stoppingToken);
                    }
                }
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                // Gracefully handle cancellation
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine($"Error in RabbitMQ listener: {ex.Message}");
            }
        }

        private async Task HandleMessage(ReservationNotifier reservation)
        {
            // we just print this message   
            _logger.LogInformation($"Reservation received: {reservation.Id}");
            await _emailSender.SendEmailAsync(
                reservation.Email,
                "You have successfully purchased a ticket using Cinebox!",
                $"Dear {reservation.Name},\nThe movie is playing {reservation.DateAndTime}\nTicket Code: {reservation.TicketCode}\nSeat number: {reservation.Seat}\nHall: {reservation.Hall}"
            );

        }

        private void OnConsumerConsumerCancelled(object sender, ConsumerEventArgs e) { }
        private void OnConsumerUnregistered(object sender, ConsumerEventArgs e) { }
        private void OnConsumerRegistered(object sender, ConsumerEventArgs e) { }
        private void OnConsumerShutdown(object sender, ShutdownEventArgs e) { }
        private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e) { }

        public override void Dispose()
        {
            _channel.Close();
            _connection.Close();
            base.Dispose();
        }
    }
}

