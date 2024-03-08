﻿using System;
namespace CineBox.Model.ViewModels
{
	public partial class Review
	{
        public int Id { get; set; }

        public int UserId { get; set; }

        public int MovieId { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; } = null!;
    }
}

