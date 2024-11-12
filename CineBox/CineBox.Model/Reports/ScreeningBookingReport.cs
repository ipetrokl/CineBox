using System;
namespace CineBox.Model.Reports
{
	public class ScreeningBookingReport
	{
        public string ScreeningTime { get; set; }
        public string MovieTitle { get; set; }
        public int TotalBookedSeats { get; set; }
    }
}

