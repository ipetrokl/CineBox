﻿using System;
namespace CineBox.Model.Requests
{
	public class ReviewUpdateRequest
	{
        public int UserId { get; set; }

        public int MovieId { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; } = null!;
    }
}

