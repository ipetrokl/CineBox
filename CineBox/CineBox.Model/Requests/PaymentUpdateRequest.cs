using System;
namespace CineBox.Model.Requests
{
	public class PaymentUpdateRequest
	{
        public int BookingId { get; set; }

        public decimal Amount { get; set; }

        public string PaymentStatus { get; set; } = null!;
    }
}

