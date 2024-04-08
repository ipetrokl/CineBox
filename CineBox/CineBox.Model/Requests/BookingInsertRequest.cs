using System;
namespace CineBox.Model.Requests
{
	public class BookingInsertRequest
	{
        public int UserId { get; set; }

        public int ScreeningId { get; set; }

        public decimal Price { get; set; }
    }
}

