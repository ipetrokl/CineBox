using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Movie
{
	public interface IMovieService : ICRUDService<Model.ViewModels.Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>
	{
        Task<Model.ViewModels.Movie> Activate(int id);
        Task<Model.ViewModels.Movie> Hide(int id);
        Task<List<string>> AllowedActions(int id);
    }
}

