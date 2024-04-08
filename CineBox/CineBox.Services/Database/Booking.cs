using System;
using System.Collections.Generic;

namespace CineBox.Services.Database;

public partial class Booking
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int ScreeningId { get; set; }

    public decimal Price { get; set; }

    public virtual ICollection<BookingSeat> BookingSeats { get; set; } = new List<BookingSeat>();

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<PromotionBooking> PromotionBookings { get; set; } = new List<PromotionBooking>();

    public virtual Screening Screening { get; set; } = null!;

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();

    public virtual User User { get; set; } = null!;
}
