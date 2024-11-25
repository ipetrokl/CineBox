using System;
using AutoMapper;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.Picture;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Movie
{
    public class MovieService : BaseCRUDService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>, IMovieService
    {
        private readonly IPictureService _pictureService;

        public MovieService(ILogger<BaseService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject>> logger, CineBoxContext context, IMapper mapper, IPictureService pictureService) : base(logger, context, mapper)
        {
            _pictureService = pictureService;
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

        public async Task<List<MoviePopularityReport>> GetTopBookedMoviesAsync()
        {
            var result = await _context.Movies
                .Join(_context.Screenings, m => m.Id, s => s.MovieId, (movie, screening) => new { movie, screening })
                .Join(_context.Bookings, x => x.screening.Id, b => b.ScreeningId, (x, booking) => new { x.movie, booking })
                .Join(_context.BookingSeats, b => b.booking.Id, bs => bs.BookingId, (booking, bookingSeat) => new { booking, bookingSeat })
                .GroupBy(x => x.booking.movie)
                .Select(g => new MoviePopularityReport
                {
                    MovieName = g.Key.Title,
                    BookingCount = g.Sum(x => 1)
                })
                .OrderByDescending(m => m.BookingCount)
                .Take(3)
                .ToListAsync();

            return result;
        }

        public override async Task BeforeInsert(Database.Movie movieEntity, MovieInsertRequest insertRequest)
        {
            if (insertRequest.PictureData != null && insertRequest.PictureData.Length > 0)
            {
                var pictureInsertRequest = new PictureInsertRequest
                {
                    Picture1 = insertRequest.PictureData
                };

                var picture = await _pictureService.Insert(pictureInsertRequest);

                movieEntity.PictureId = picture.Id;
            }
        }

        public override async Task BeforeUpdate(Database.Movie movieEntity, MovieUpdateRequest updateRequest)
        {
            if (updateRequest.PictureData != null && updateRequest.PictureData.Length > 0)
            {
                if (movieEntity.PictureId.HasValue)
                {
                    var pictureUpdateRequest = new PictureUpdateRequest
                    {
                        Picture1 = updateRequest.PictureData
                    };

                    await _pictureService.Update(movieEntity.PictureId.Value, pictureUpdateRequest);
                }
                else
                {
                    var pictureInsertRequest = new PictureInsertRequest
                    {
                        Picture1 = updateRequest.PictureData
                    };

                    var picture = await _pictureService.Insert(pictureInsertRequest);
                    movieEntity.PictureId = picture.Id;
                }
            }
        }

        public override async Task<bool> Delete(int id)
        {
            var movieEntity = await _context.Movies
                .Include(m => m.Picture)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (movieEntity == null)
            {
                return false;
            }

            if (movieEntity.PictureId.HasValue)
            {
                var pictureId = movieEntity.PictureId.Value;

                var pictureUsageCount = await _context.Movies
                    .Where(m => m.PictureId == pictureId)
                    .CountAsync();

                if (pictureUsageCount == 1)
                {
                    var pictureEntity = await _context.Pictures.FindAsync(pictureId);
                    if (pictureEntity != null)
                    {
                        _context.Pictures.Remove(pictureEntity);
                    }
                }
            }

            _context.Movies.Remove(movieEntity);
            await _context.SaveChangesAsync();

            return true;
        }
    }
}

