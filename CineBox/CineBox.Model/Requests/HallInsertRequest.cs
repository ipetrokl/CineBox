using System;
namespace CineBox.Model.Requests
{
	public class HallInsertRequest
	{
        public int CinemaId { get; set; }

        public string Name { get; set; } = null!;
    }
}

