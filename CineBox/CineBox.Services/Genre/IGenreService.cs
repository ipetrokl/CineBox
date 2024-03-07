using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Genre
{
	public interface IGenreService : ICRUDService<Model.ViewModels.Genre, GenreSearchObject, GenreInsertRequest, GenreUpdateRequest>
	{
	
	}
}

