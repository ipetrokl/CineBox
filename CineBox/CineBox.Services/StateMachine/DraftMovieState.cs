using System;
using System.Text;
using AutoMapper;
using Azure.Core;
using CineBox.Model.Requests;
using CineBox.Services.Database;
using EasyNetQ;
using Microsoft.Extensions.Logging;
using RabbitMQ.Client;

namespace CineBox.Services.StateMachine
{
    public class DraftMovieState : BaseState
    {
        protected ILogger<DraftMovieState> _logger; 

        public DraftMovieState(ILogger<DraftMovieState> logger, IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper) : base(logger, serviceProvider, context, mapper)
        {
            _logger = logger;
        }

        public override async Task<Model.ViewModels.Movie> Update(int id, MovieUpdateRequest request)
        {
            var set = _context.Set<Database.Movie>();

            var entity = await set.FindAsync(id);

            _mapper.Map(request, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.ViewModels.Movie>(entity);
        }

        public override async Task<Model.ViewModels.Movie> Activate(int id)
        {
            var set = _context.Set<Database.Movie>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();

            //RabbitMQ
            //var factory = new ConnectionFactory { HostName = "localhost" };
            //using var connection = factory.CreateConnection();
            //using var channel = connection.CreateModel();

            //channel.QueueDeclare(queue: "movie_added",
            //                     durable: false,
            //                     exclusive: false,
            //                     autoDelete: false,
            //                     arguments: null);

            //const string message = "Hello World!";
            //var body = Encoding.UTF8.GetBytes(message);

            //channel.BasicPublish(exchange: string.Empty,
            //                     routingKey: "movie_added",
            //                     basicProperties: null,
            //                     body: body);

            var mappedEntity = _mapper.Map<Model.ViewModels.Movie>(entity);

            //EasyNetQ
            using var bus = RabbitHutch.CreateBus("host=localhost");
            bus.PubSub.Publish(mappedEntity);
            
            return mappedEntity;
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("update");
            list.Add("activate");
            return list;
        }
    }
}

