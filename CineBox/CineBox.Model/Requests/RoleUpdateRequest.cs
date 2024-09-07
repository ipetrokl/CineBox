using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class RoleUpdateRequest
	{

        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }

        public string Description { get; set; } = "";
    }
}

