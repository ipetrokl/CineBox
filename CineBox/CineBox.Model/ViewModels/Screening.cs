using System;
namespace CineBox.Model.ViewModels
{
	public partial class Screening
	{
        public int Id { get; set; }

        public int MovieId { get; set; }

        public int CinemaId { get; set; }

        public string Category { get; set; } = null!;

        public DateTime StartTime { get; set; }

        public DateTime EndTime { get; set; }

        public decimal Price { get; set; }
    }
}

