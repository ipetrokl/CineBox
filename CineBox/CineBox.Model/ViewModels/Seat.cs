
namespace CineBox.Model.ViewModels
{
    public partial class Seat
    {
        public int Id { get; set; }

        public int HallId { get; set; }

        public int SeatNumber { get; set; }

        public string Category { get; set; } = null!;

        public bool Status { get; set; }

        public virtual Hall Hall { get; set; } = null!;
    }
}