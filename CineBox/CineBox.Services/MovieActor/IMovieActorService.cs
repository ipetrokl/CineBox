using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.MovieActor
{
	public interface IMovieActorService : ICRUDService<Model.ViewModels.MovieActor, MovieActorSearchObject, MovieActorInsertRequest, MovieActorUpdateRequest>
	{
	}
}

