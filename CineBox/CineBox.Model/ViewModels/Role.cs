﻿using System;
namespace CineBox.Model.ViewModels
{
    public partial class Role
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string? Description { get; set; }

    }
}

