using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
    public class ActorUpdateRequest
	{
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
    }
}

