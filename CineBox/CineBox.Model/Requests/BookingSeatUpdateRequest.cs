using System;
namespace CineBox.Model.Requests
{
	public class BookingSeatUpdateRequest
	{
        public int BookingId { get; set; }

        public int SeatId { get; set; }
    }
}

