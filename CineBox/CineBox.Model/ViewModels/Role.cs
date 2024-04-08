using System;
namespace CineBox.Model.ViewModels
{
    public partial class Role
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string? Descripotion { get; set; }

        public virtual ICollection<UsersRole> UsersRoles { get; set; } = new List<UsersRole>();
    }
}

