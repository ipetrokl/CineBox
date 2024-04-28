using System;
namespace CineBox.Model.Requests
{
	public class UserInsertRequest
	{
        public string Name { get; set; } = null!;

        public string Surname { get; set; } = null!;

        public string? Email { get; set; }

        public string? Phone { get; set; }

        public string Username { get; set; } = null!;

        public bool Status { get; set; } = true;

        public string? Password { get; set; }

        public string? PasswordConfirmation { get; set; }
    }
}

