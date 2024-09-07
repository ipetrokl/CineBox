using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class UsersRoleUpdateRequest
	{

        [Required(ErrorMessage = "The User is required")]
        public int? UserId { get; set; }

        [Required(ErrorMessage = "The Role is required")]
        public int? RoleId { get; set; }

        [Required]
        public DateTime? DateOfModification { get; set; }
    }
}

