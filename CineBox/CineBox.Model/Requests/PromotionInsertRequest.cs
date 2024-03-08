using System;
namespace CineBox.Model.Requests
{
	public class PromotionInsertRequest
	{
        public string Code { get; set; } = null!;

        public decimal Discount { get; set; }

        public DateTime ExpirationDate { get; set; }
    }
}

