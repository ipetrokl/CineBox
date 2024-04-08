using System;
namespace CineBox.Model.Requests
{
	public class TicketInsertRequest
	{
        public int BookingId { get; set; }

        public string TicketCode { get; set; } = null!;

        public string QrCode { get; set; } = null!;

        public decimal Price { get; set; }
    }
}

