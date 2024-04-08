using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Screening
{
    public int Id { get; set; }

    public int MovieId { get; set; }

    public int CinemaId { get; set; }

    public string Category { get; set; } = null!;

    public DateTime StartTime { get; set; }

    public DateTime EndTime { get; set; }

    public decimal Price { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual Cinema Cinema { get; set; } = null!;

    public virtual Movie Movie { get; set; } = null!;
}
