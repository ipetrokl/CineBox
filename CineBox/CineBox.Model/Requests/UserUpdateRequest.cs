using System;
namespace CineBox.Model.Requests
{
	public class UserUpdateRequest
	{
        public string Name { get; set; } = null!;

        public string Surname { get; set; } = null!;

        public string? Email { get; set; }

        public string? Phone { get; set; }

        public bool Status { get; set; }

        public string Password { get; set; }

        public string PasswordConfirmation { get; set; }
    }
}

