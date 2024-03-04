using System;
namespace CineBox.Model.ViewModels
{
    public partial class Movie
    {
        public int Id { get; set; }

        public string Title { get; set; } = null!;

        public string Description { get; set; } = null!;

        public DateTime ReleaseDate { get; set; }

        public int Duration { get; set; }

        public string Genre { get; set; } = null!;

        public string Director { get; set; } = null!;

        public byte[]? Picture { get; set; }

        public byte[]? PictureThumb { get; set; }

        public string? StateMachine { get; set; }
    }
}

