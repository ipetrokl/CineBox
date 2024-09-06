using System;
using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests
{
	public class ActorInsertRequest
	{
        [Required(AllowEmptyStrings = false)]
        public string Name { get; set; }
    }
}

