using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Cinema
{
	public interface ICinemaService : ICRUDService<Model.ViewModels.Cinema, CinemaSearchObject, CinemaInsertRequest, CinemaUpdateRequest>
	{
        
    }
}

