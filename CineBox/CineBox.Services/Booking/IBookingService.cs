using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Booking
{
	public interface IBookingService : ICRUDService<Model.ViewModels.Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>
	{
	}
}

