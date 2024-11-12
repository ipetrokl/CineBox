using System;
using AutoMapper;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Screening
{
    public class ScreeningService : BaseCRUDService<Model.ViewModels.Screening, Database.Screening, ScreeningSearchObject, ScreeningInsertRequest, ScreeningUpdateRequest>, IScreeningService
    {
        public ScreeningService(ILogger<BaseService<Model.ViewModels.Screening, Database.Screening, ScreeningSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Screening> AddFilter(IQueryable<Database.Screening> query, ScreeningSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.Movie)
                    .Where(x => x.Movie.Title.Contains(search.FTS) || x.Category.Contains(search.FTS));
            }

            if (!string.IsNullOrWhiteSpace(search?.Category))
            {
                filteredQuery = filteredQuery.Where(x => x.Category == search.Category);
            }

            if (search?.MovieId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.MovieId == search.MovieId);
            }

            if (search?.HallId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.HallId == search.HallId);
            }

            if (search?.CinemaId != null)
            {
                filteredQuery = filteredQuery
                    .Include(x => x.Hall)
                    .Where(x => x.Hall.CinemaId == search.CinemaId);
            }

            if (search?.SelectedDate != null)
            {
                if (search.SelectedDate.Value.Date.Equals(DateTime.Today))
                {
                    filteredQuery = filteredQuery
                    .Where(x => x.ScreeningTime.Date.Equals(search.SelectedDate.Value.Date) && (x.ScreeningTime.TimeOfDay > search.SelectedDate.Value.TimeOfDay));
                } else
                {
                    filteredQuery = filteredQuery
                    .Where(x => x.ScreeningTime.Date.Equals(search.SelectedDate.Value.Date));
                }
                 
            }

            return filteredQuery;
        }

        public override IQueryable<Database.Screening> AddInclude(IQueryable<Database.Screening> query, ScreeningSearchObject? search = null)
        {
            return query
                 .Include(x => x.Movie);

        }

        public async Task<List<ScreeningBookingReport>> GetTopScreeningTimesAsync()
        {
            try
            {
                var result = await _context.Screenings
                    .Include(s => s.Movie)
                    .Join(_context.Bookings, s => s.Id, b => b.ScreeningId, (screening, booking) => new { screening, booking })
                    .Join(_context.BookingSeats, b => b.booking.Id, bs => bs.BookingId, (booking, bookingSeat) => new { booking, bookingSeat })
                    .GroupBy(x => new
                    {
                        ScreeningTime = x.booking.screening.ScreeningTime.Hour,
                        MovieName = x.booking.screening.Movie.Title
                    })
                    .Select(g => new
                    {
                        ScreeningTime = g.Key.ScreeningTime,
                        MovieTitle = g.Key.MovieName,
                        TotalBookedSeats = g.Sum(x => 1)
                    })
                    .ToListAsync();

                var finalResult = result.Select(r => new ScreeningBookingReport
                {
                    ScreeningTime = r.ScreeningTime.ToString(),
                    MovieTitle = r.MovieTitle,
                    TotalBookedSeats = r.TotalBookedSeats
                })
                .OrderByDescending(r => r.TotalBookedSeats)
                .ToList();

                return finalResult;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return new List<ScreeningBookingReport>();
            }
        }

    }
}

