using System;
namespace CineBox.Model.Requests
{
	public class NewsInsertRequest
	{
        public int CinemaId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public DateTime CreatedDate { get; set; }
    }
}

