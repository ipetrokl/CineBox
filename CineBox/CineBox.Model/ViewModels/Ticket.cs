using System;
namespace CineBox.Model.ViewModels
{
	public partial class Ticket
	{
        public int Id { get; set; }

        public int BookingId { get; set; }

        public string TicketCode { get; set; } = null!;

        public string QrCode { get; set; } = null!;

        public decimal Price { get; set; }
    }
}

