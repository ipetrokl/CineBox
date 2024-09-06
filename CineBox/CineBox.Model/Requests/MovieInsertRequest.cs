using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
    public partial class MovieInsertRequest
    {
        [Required(ErrorMessage = "The Genre is required")]
        public int? GenreId { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Title { get; set; }

        public string Description { get; set; } = "";

        [Required]
        public DateTime? PerformedFrom { get; set; }

        [Required]
        public DateTime? PerformedTo { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Director { get; set; }

        public byte[]? Picture { get; set; }

        public byte[]? PictureThumb { get; set; }
    }
}

