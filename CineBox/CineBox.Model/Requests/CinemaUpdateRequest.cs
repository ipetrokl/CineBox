using System;
namespace CineBox.Model.Requests
{
	public class CinemaUpdateRequest
	{
        public string Name { get; set; } = null!;

        public string Location { get; set; } = null!;
    }
}

