using System.ComponentModel.DataAnnotations;

namespace CineBox.Model.Requests;

public class SeatUpdateRequest
{
    [Required(ErrorMessage = "The Hall is required")]
    public int? HallId { get; set; }

    [Required(AllowEmptyStrings = false)]
    public int? SeatNumber { get; set; }

    [Required(AllowEmptyStrings = false)]
    public string Category { get; set; }

    public bool Status { get; set; }
}
