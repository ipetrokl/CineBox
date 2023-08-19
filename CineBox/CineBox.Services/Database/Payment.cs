using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Payment
{
    public int Id { get; set; }

    public int BookingId { get; set; }

    public decimal Amount { get; set; }

    public string PaymentStatus { get; set; } = null!;

    public virtual Booking Booking { get; set; } = null!;
}
