using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
    public class NewsInsertRequest
    {
        [Required(ErrorMessage = "The Cinema is required")]
        public int? CinemaId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Description { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}

