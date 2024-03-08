using System;
namespace CineBox.Model.Requests
{
	public class BookingSeatInsertRequest
	{
        public int BookingId { get; set; }

        public int SeatId { get; set; }
    }
}

