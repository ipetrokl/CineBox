using System;
namespace MailService.Models
{
	public class ErrorViewModel
	{
        public string? RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}

