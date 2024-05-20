using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class News
{
    public int Id { get; set; }

    public int CinemaId { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public DateTime CreatedDate { get; set; }

    public virtual Cinema Cinema { get; set; } = null!;
}
