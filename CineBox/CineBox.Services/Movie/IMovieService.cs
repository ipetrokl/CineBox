using System;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Movie
{
	public interface IMovieService : ICRUDService<Model.ViewModels.Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>
	{
        Task<List<MoviePopularityReport>> GetTopBookedMoviesAsync();
    }
}

