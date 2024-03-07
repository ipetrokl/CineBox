using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Hall
{
	public interface IHallService : ICRUDService<Model.ViewModels.Hall, HallSearchObject, HallInsertRequest, HallUpdateRequest>
	{
		
	}
}

