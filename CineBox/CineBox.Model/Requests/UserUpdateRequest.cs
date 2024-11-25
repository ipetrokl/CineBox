using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class UserUpdateRequest
	{
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Surname { get; set; }

        [Required(AllowEmptyStrings = false)]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", ErrorMessage = "Please enter a valid email address.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "The Phone number is required")]
        [RegularExpression(@"^\+?\d{9,15}$", ErrorMessage = "Invalid phone number format")]
        public string Phone { get; set; }

        public bool Status { get; set; } = true;

        public string? Password { get; set; }
        
        public string? PasswordConfirmation { get; set; }

        public byte[]? PictureData { get; set; }
    }
}

