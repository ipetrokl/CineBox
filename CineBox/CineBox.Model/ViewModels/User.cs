using System;
namespace CineBox.Model.ViewModels
{
	public partial class User
	{
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string Surname { get; set; } = null!;

        public string? Email { get; set; }

        public string? Phone { get; set; }

        public string Username { get; set; } = null!;

        public bool Status { get; set; }

        public int? PictureId { get; set; }

        public virtual ICollection<UsersRole> UsersRoles { get; set; } = new List<UsersRole>();

        public virtual Picture? Picture { get; set; }
    }
}

