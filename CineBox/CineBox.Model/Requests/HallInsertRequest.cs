using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class HallInsertRequest
	{
        [Required(ErrorMessage = "The Cinema is required")]
        public int? CinemaId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
    }
}

