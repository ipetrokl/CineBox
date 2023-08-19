using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Cinema
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Location { get; set; } = null!;

    public virtual ICollection<Hall> Halls { get; set; } = new List<Hall>();

    public virtual ICollection<Screening> Screenings { get; set; } = new List<Screening>();
}
