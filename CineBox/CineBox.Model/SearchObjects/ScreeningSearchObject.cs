using System;
namespace CineBox.Model.SearchObjects
{
	public class ScreeningSearchObject : BaseSearchObject
	{
        public string? FTS { get; set; }
        public string? Category { get; set; }
        public int? MovieId { get; set; }
        public int? HallId { get; set; }
        public int? CinemaId { get; set; }
    }
}

