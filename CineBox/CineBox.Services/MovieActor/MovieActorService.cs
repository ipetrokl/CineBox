using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.MovieActor
{
    public class MovieActorService : BaseCRUDService<Model.ViewModels.MovieActor, Database.MovieActor, MovieActorSearchObject, MovieActorInsertRequest, MovieActorUpdateRequest>, IMovieActorService
    {
        public MovieActorService(ILogger<BaseService<Model.ViewModels.MovieActor, Database.MovieActor, MovieActorSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

