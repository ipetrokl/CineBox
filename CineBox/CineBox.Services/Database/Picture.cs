using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Picture
{
    public int Id { get; set; }

    public byte[]? Picture1 { get; set; }

    public virtual ICollection<Movie> Movies { get; set; } = new List<Movie>();
}
