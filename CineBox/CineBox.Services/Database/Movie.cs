using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Movie
{
    public int Id { get; set; }

    public int GenreId { get; set; }

    public string Title { get; set; } = null!;

    public string Description { get; set; } = null!;

    public DateTime PerformedFrom { get; set; }

    public DateTime PerformedTo { get; set; }

    public string Director { get; set; } = null!;

    public int? PictureId { get; set; }

    public virtual Genre Genre { get; set; } = null!;

    public virtual ICollection<MovieActor> MovieActors { get; set; } = new List<MovieActor>();

    public virtual Picture? Picture { get; set; }

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();

    public virtual ICollection<Screening> Screenings { get; set; } = new List<Screening>();
}
