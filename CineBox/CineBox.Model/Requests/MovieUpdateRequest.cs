using System;
namespace CineBox.Model.Requests
{
    public partial class MovieUpdateRequest
    {
        public string Title { get; set; } = null!;

        public string Description { get; set; } = null!;

        public DateTime ReleaseDate { get; set; }

        public int Duration { get; set; }

        public string Director { get; set; } = null!;

        public byte[]? Picture { get; set; }

        public byte[]? PictureThumb { get; set; }
    }
}

