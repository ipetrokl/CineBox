using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Review
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int MovieId { get; set; }

    public int Rating { get; set; }

    public string Comment { get; set; } = null!;

    public virtual Movie Movie { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
