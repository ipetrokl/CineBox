﻿using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Promotion
{
    public int Id { get; set; }

    public string Code { get; set; } = null!;

    public decimal Discount { get; set; }

    public DateTime ExpirationDate { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();
}
