using System;
namespace CineBox.Model.ViewModels
{
	public partial class Booking
	{
        public int Id { get; set; }

        public int UserId { get; set; }

        public int ScreeningId { get; set; }

        public decimal Price { get; set; }

        public int PromotionId { get; set; }

        public virtual Screening Screening { get; set; } = null!;

        public virtual Promotion Promotion { get; set; } = null!;
    }
}

