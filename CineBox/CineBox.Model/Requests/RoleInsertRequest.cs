using System;
namespace CineBox.Model.Requests
{
	public class RoleInsertRequest
	{
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string? Descripotion { get; set; }
    }
}

