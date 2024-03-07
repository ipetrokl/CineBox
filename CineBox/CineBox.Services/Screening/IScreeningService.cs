using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Screening
{
	public interface IScreeningService : ICRUDService<Model.ViewModels.Screening, ScreeningSearchObject, ScreeningInsertRequest, ScreeningUpdateRequest>
	{
		
	}
}

