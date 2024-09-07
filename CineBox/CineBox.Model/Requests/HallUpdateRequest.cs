using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class HallUpdateRequest
	{
        [Required(ErrorMessage = "The Cinema is required")]
        public int? CinemaId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
    }
}

