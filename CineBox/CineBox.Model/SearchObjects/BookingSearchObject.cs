using System;
namespace CineBox.Model.SearchObjects
{
	public class BookingSearchObject : BaseSearchObject
	{
        public string? FTS { get; set; }
        public int? ScreeningId { get; set; }
    }
}

