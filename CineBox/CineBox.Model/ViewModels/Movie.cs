using System;
namespace CineBox.Model.ViewModels
{
    public partial class Movie
    {
        public int Id { get; set; }

        public int GenreId { get; set; }

        public string Title { get; set; } = null!;

        public string Description { get; set; } = null!;

        public DateTime PerformedFrom { get; set; }

        public DateTime PerformedTo { get; set; }

        public string Director { get; set; } = null!;

        public byte[]? Picture { get; set; }

        public byte[]? PictureThumb { get; set; }

        public virtual Genre Genre { get; set; } = null!;
    }
}

