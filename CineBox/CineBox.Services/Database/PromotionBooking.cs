using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class PromotionBooking
{
    public int Id { get; set; }

    public int PromotionId { get; set; }

    public int BookingId { get; set; }

    public virtual Booking Booking { get; set; } = null!;

    public virtual Promotion Promotion { get; set; } = null!;
}
