using System;
using System.Net;
using System.Net.Mail;

namespace MailService
{
    public class EmailSender : IEmailSender
    {
        private readonly string _outlookMail = Environment.GetEnvironmentVariable("SENDER_MAIL") ?? "cineboxsender@gmail.com";
        private readonly string _outlookPass = Environment.GetEnvironmentVariable("SENDER_PASS") ?? "coyr oncp ygks wlat";

        public EmailSender()
        {
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_outlookMail, _outlookPass)
            };

            return client.SendMailAsync(
                new MailMessage(from: _outlookMail,
                                to: email,
                                subject,
                                message
                                ));

        }
    }
}

