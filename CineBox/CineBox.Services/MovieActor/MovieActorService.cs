using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.MovieActor
{
    public class MovieActorService : BaseCRUDService<Model.ViewModels.MovieActor, Database.MovieActor, MovieActorSearchObject, MovieActorInsertRequest, MovieActorUpdateRequest>, IMovieActorService
    {
        public MovieActorService(ILogger<BaseService<Model.ViewModels.MovieActor, Database.MovieActor, MovieActorSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.MovieActor> AddFilter(IQueryable<Database.MovieActor> query, MovieActorSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.Movie)
                    .Include(x => x.Actor)
                    .Where(x => x.Movie.Title.Contains(search.FTS) || x.Actor.Name.Contains(search.FTS));
            }

            if (search?.MovieId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.MovieId == search.MovieId);
            }

            return filteredQuery;
        }
    }
}

