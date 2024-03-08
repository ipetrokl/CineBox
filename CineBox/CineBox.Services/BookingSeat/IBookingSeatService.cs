using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.BookingSeat
{
	public interface IBookingSeatService : ICRUDService<Model.ViewModels.BookingSeat, BookingSeatSearchObject, BookingSeatInsertRequest, BookingSeatUpdateRequest>
	{
	}
}

