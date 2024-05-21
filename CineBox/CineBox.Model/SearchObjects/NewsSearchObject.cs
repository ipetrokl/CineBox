using System;
namespace CineBox.Model.SearchObjects
{
    public class NewsSearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }
        public int? CinemaId { get; set; }
    }
}

