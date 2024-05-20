using System;
namespace CineBox.Model.Requests
{
	public class BookingUpdateRequest
	{
        public int UserId { get; set; }

        public int ScreeningId { get; set; }

        public decimal Price { get; set; }

        public int PromotionId { get; set; }
    }
}

