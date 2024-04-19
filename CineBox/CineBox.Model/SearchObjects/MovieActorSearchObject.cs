using System;
namespace CineBox.Model.SearchObjects
{
	public class MovieActorSearchObject : BaseSearchObject
	{
        public string? FTS { get; set; }
        public int? MovieId { get; set; }
    }
}

