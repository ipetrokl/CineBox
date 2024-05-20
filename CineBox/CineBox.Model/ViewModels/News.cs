using System;
namespace CineBox.Model.ViewModels
{
    public partial class News
    {
        public int Id { get; set; }

        public int CinemaId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public DateTime CreatedDate { get; set; }
    }
}

