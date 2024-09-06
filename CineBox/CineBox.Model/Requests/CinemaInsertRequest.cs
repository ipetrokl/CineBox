using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class CinemaInsertRequest
	{
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Location { get; set; }
    }
}

