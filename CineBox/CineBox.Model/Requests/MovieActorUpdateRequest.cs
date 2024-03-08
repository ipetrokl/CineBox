using System;
namespace CineBox.Model.Requests
{
	public class MovieActorUpdateRequest
	{
        public int MovieId { get; set; }

        public int ActorId { get; set; }
    }
}

