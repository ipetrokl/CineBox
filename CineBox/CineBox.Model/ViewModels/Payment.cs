using System;
namespace CineBox.Model.ViewModels
{
	public partial class Payment
	{
        public int Id { get; set; }

        public int BookingId { get; set; }

        public decimal Amount { get; set; }

        public string PaymentStatus { get; set; } = null!;
    }
}

