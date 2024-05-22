using System;
namespace CineBox.Model.SearchObjects
{
	public class PromotionSearchObject : BaseSearchObject
	{
        public string? FTS { get; set; }
        public DateTime? CurrentDate { get; set; }
    }
}

