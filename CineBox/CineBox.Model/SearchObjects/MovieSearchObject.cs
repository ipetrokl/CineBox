using System;

namespace CineBox.Model.SearchObjects
{
	public class MovieSearchObject : BaseSearchObject
	{
		public string? FTS { get; set; }
		public string? Description { get; set; }
		public int? CinemaId { get; set; }
		public DateTime? SelectedDate { get; set; }
		public int? GenreId { get; set; }
	}
}

