using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Actor
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<MovieActor> MovieActors { get; set; } = new List<MovieActor>();
}
