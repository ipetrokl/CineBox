using System;
namespace CineBox.Model.SearchObjects
{
	public class MovieSearchObject : BaseSearchObject
	{
		public string? FTS { get; set; }
		public string? Description { get; set; }
	}
}

