using System;
namespace CineBox.Model.ViewModels
{
	public partial class Screening
	{
        public int Id { get; set; }

        public int MovieId { get; set; }

        public int HallId { get; set; }

        public string Category { get; set; } = null!;

        public DateTime ScreeningTime { get; set; }

        public decimal Price { get; set; }

        public virtual Hall Hall { get; set; } = null!;

        public virtual Movie Movie { get; set; } = null!;
    }
}

