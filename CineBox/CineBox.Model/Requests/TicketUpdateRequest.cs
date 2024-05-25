using System;
namespace CineBox.Model.Requests
{
	public class TicketUpdateRequest
	{
        public int BookingId { get; set; }

        public string TicketCode { get; set; } = null!;

        public string QrCode { get; set; } = null!;

        public decimal Price { get; set; }

        public int UserId { get; set; }

        public int BookingSeatId { get; set; }
    }
}

