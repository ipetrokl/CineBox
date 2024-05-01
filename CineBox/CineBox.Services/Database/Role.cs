using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Role
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<UsersRole> UsersRoles { get; set; } = new List<UsersRole>();
}
