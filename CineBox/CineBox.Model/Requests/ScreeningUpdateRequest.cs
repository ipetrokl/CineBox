using System;
namespace CineBox.Model.Requests
{
	public class ScreeningUpdateRequest
	{
        public int MovieId { get; set; }

        public int CinemaId { get; set; }

        public string Category { get; set; } = null!;

        public DateTime StartTime { get; set; }

        public DateTime EndTime { get; set; }
    }
}

