﻿using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
    public partial class MovieUpdateRequest
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

        [Required(ErrorMessage = "The Picture is required")]
        public byte[]? PictureData { get; set; }
    }
}

