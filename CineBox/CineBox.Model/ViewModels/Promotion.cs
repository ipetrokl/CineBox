using System;
namespace CineBox.Model.ViewModels
{
	public partial class Promotion
	{
        public int Id { get; set; }

        public string Code { get; set; } = null!;

        public decimal Discount { get; set; }

        public DateTime ExpirationDate { get; set; }
    }
}

