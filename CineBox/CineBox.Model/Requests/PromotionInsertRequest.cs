using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class PromotionInsertRequest
	{
        [Required(AllowEmptyStrings = false)]
        public string Code { get; set; }

        [Required(AllowEmptyStrings = false)]
        [Range(1.00, 100.00, ErrorMessage = "The Discount must be between 1% and 100%")]
        public decimal? Discount { get; set; }

        [Required]
        public DateTime? ExpirationDate { get; set; }
    }
}

