using System;
namespace CineBox.Model.Reports
{
	public class HallOccupancyReport
	{
        public string? HallName { get; set; }
        public int? OccupiedSeats { get; set; }
        public int? TotalSeats { get; set; }
    }
}

