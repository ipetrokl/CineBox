using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Hall
{
    public int Id { get; set; }

    public int CinemaId { get; set; }

    public string Name { get; set; } = null!;

    public virtual Cinema Cinema { get; set; } = null!;

    public virtual ICollection<Seat> Seats { get; set; } = new List<Seat>();
}
