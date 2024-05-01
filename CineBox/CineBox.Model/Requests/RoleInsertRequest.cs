using System;
namespace CineBox.Model.Requests
{
	public class RoleInsertRequest
	{

        public string Name { get; set; } = null!;

        public string? Description { get; set; }
    }
}

