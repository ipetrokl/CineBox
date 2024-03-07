using System;
namespace CineBox.Model.ViewModels
{
    public partial class Cinema
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string Location { get; set; } = null!;
    }
}

