using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Booking
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int ScreeningId { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual Screening Screening { get; set; } = null!;

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();

    public virtual User User { get; set; } = null!;

    public virtual ICollection<Seat> Seats { get; set; } = new List<Seat>();
}
