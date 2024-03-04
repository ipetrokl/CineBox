using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class BookingSeat
{
    public int BookingSeatId { get; set; }

    public int BookingId { get; set; }

    public int SeatId { get; set; }

    public virtual Booking Booking { get; set; } = null!;

    public virtual Seat Seat { get; set; } = null!;
}
