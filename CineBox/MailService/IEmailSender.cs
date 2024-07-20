using System;
namespace MailService
{
	public interface IEmailSender
	{
        Task SendEmailAsync(string email, string subject, string message);
    }
}

