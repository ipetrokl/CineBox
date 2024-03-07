using System;
namespace CineBox.Model.ViewModels
{
	public partial class Hall
	{
        public int Id { get; set; }

        public int CinemaId { get; set; }

        public string Name { get; set; } = null!;
    }
}

