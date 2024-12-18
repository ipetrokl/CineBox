﻿using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class UserInsertRequest
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

        [Required]
        [MinLength(4)]
        public string Username { get; set; }

        public bool Status { get; set; } = true;

        [Required]
        [StringLength(50, MinimumLength = 4)]
        [DataType(DataType.Password)]
        [Compare("PasswordConfirmation", ErrorMessage = "Passwords do not match.")]
        public string Password { get; set; }

        [Required]
        [Compare("Password", ErrorMessage = "Passwords do not match.")]
        public string PasswordConfirmation { get; set; }

        public byte[]? PictureData { get; set; }
    }
}

