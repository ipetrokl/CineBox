using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Movie
{
    public class MovieService : BaseCRUDService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>, IMovieService
    {

        public MovieService(ILogger<BaseService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Movie> AddFilter(IQueryable<Database.Movie> query, MovieSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Title.Contains(search.FTS) || x.Description.Contains(search.FTS));
            }

            if (!string.IsNullOrWhiteSpace(search?.Description))
            {
                filteredQuery = filteredQuery.Where(x => x.Description == search.Description);
            }

            if (search?.CinemaId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Screenings.Any(s => s.Hall.CinemaId == search.CinemaId) && (DateTime.Now >= x.PerformedFrom && DateTime.Now <= x.PerformedTo));
            }

            if (search?.SelectedDate != null)
            {
                filteredQuery = filteredQuery.Where(x => search.SelectedDate >= x.PerformedFrom && search.SelectedDate <= x.PerformedTo);
            }

            if (search?.SelectedDate != null && search?.GenreId != null)
            {
                filteredQuery = filteredQuery.Where(x => search.SelectedDate >= x.PerformedFrom && search.SelectedDate <= x.PerformedTo && x.GenreId == search.GenreId);
            }

            filteredQuery = filteredQuery
                .Select(movie => new
                {
                    Movie = movie,
                    AverageRating = movie.Reviews.Any() ? movie.Reviews.Average(r => r.Rating) : 0
                })
                .OrderByDescending(m => m.AverageRating)
                .ThenBy(m => m.Movie.Title)
                .Select(m => m.Movie);

            return filteredQuery;
        }

        public override IQueryable<Database.Movie> AddInclude(IQueryable<Database.Movie> query, MovieSearchObject? search = null)
        {
            return query
                 .Include(x => x.Genre)
                 .Include(x => x.Picture);
        }
    }
}

