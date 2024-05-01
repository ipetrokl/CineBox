using System;
namespace CineBox.Model.Requests
{
    public partial class MovieInsertRequest
    {
        public int GenreId { get; set; }

        public string Title { get; set; } = null!;

        public string Description { get; set; } = null!;

        public DateTime PerformedFrom { get; set; }

        public DateTime PerformedTo { get; set; }

        public string Director { get; set; } = null!;

        public byte[]? Picture { get; set; }

        public byte[]? PictureThumb { get; set; }
    }
}

