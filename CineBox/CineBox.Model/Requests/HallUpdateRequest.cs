using System;
namespace CineBox.Model.Requests
{
	public class HallUpdateRequest
	{
        public int CinemaId { get; set; }

        public string Name { get; set; } = null!;
    }
}

