using System;
namespace CineBox.Model.Requests
{
	public class ScreeningUpdateRequest
	{
        public int MovieId { get; set; }

        public int HallId { get; set; }

        public string Category { get; set; } = null!;

        public DateTime ScreeningTime { get; set; }

        public decimal Price { get; set; }
    }
}

