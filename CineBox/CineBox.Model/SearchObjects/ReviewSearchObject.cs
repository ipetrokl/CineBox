using System;
namespace CineBox.Model.SearchObjects
{
	public class ReviewSearchObject : BaseSearchObject
	{
        public string? FTS { get; set; }

        public int? UserId { get; set; }
    }
}

