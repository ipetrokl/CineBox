﻿using System;
namespace CineBox.Model.ViewModels
{
    public partial class UsersRole
    {
        public int UsersRolesId { get; set; }

        public int UserId { get; set; }

        public int RoleId { get; set; }

        public DateTime DateOfModification { get; set; }

        public virtual Role Role { get; set; } = null!;

    }
}

