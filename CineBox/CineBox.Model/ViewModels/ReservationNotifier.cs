using System;
namespace CineBox.Model.ViewModels
{
    public class ReservationNotifier
    {
        public ReservationNotifier()
        {
        }
        public int Id { get; set; }
        public string TicketCode { get; set; }
        public int Seat { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Hall { get; set; }
        public DateTime DateAndTime { get; set; }
    }
}

