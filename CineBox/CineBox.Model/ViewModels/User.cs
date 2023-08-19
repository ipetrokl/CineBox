using System;
namespace CineBox.Model.ViewModels
{
	public class User
	{
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string Surname { get; set; } = null!;

        public string? Email { get; set; }

        public string? Phone { get; set; }

        public string Username { get; set; } = null!;

        public bool Status { get; set; }
    }
}

