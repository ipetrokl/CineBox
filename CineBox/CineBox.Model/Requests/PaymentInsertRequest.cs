using System;
namespace CineBox.Model.Requests
{
	public class PaymentInsertRequest
	{
        public int BookingId { get; set; }

        public decimal Amount { get; set; }

        public string PaymentStatus { get; set; } = null!;
    }
}

