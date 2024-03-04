using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Seat
{
    public int Id { get; set; }

    public int HallId { get; set; }

    public int SeatNumber { get; set; }

    public string Category { get; set; } = null!;

    public string Status { get; set; } = null!;

    public virtual Hall Hall { get; set; } = null!;

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();
}
