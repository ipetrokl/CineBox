using System;
using CineBox.Model.ViewModels;

namespace CineBox.Model.SearchObjects
{
	public class BookingSeatSearchObject : BaseSearchObject
	{
		public List<int>? BookingIds { get; set; }
	}
}


