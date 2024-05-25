using System;
namespace CineBox.Model.SearchObjects
{
	public class TicketSearchObject : BaseSearchObject
	{
        public string? FTS { get; set; }
        public DateTime? currentDate { get; set; }
        public int? UserId { get; set; }
    }
}

