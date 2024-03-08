namespace CineBox.Model.Requests;

public class SeatUpdateRequest
{
    public int HallId { get; set; }

    public int SeatNumber { get; set; }

    public string Category { get; set; } = null!;

    public string Status { get; set; } = null!;
}
