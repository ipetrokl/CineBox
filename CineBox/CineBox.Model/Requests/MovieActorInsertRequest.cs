using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class MovieActorInsertRequest
	{
        [Required(ErrorMessage = "The Movie is required")]
        public int? MovieId { get; set; }

        [Required(ErrorMessage = "The Actor is required")]
        public int? ActorId { get; set; }
    }
}

