﻿using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Seat
{
    public int Id { get; set; }

    public int HallId { get; set; }

    public int SeatNumber { get; set; }

    public string Category { get; set; } = null!;

    public string Status { get; set; } = null!;

    public virtual ICollection<BookingSeat> BookingSeats { get; set; } = new List<BookingSeat>();

    public virtual Hall Hall { get; set; } = null!;
}
