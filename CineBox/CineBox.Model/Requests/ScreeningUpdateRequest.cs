using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class ScreeningUpdateRequest
	{
        [Required(ErrorMessage = "The Movie is required")]
        public int? MovieId { get; set; }

        [Required(ErrorMessage = "The Hall is required")]
        public int? HallId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Category { get; set; } = null!;

        [Required]
        public DateTime? ScreeningTime { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Range(0.01, 1000.00, ErrorMessage = "The Price must be between 0.01€ and 1,000.00€")]
        public decimal? Price { get; set; }
    }
}

