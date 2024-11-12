using System;
using AutoMapper;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Hall
{
    public class HallService : BaseCRUDService<Model.ViewModels.Hall, Database.Hall, HallSearchObject, HallInsertRequest, HallUpdateRequest>, IHallService
    {
        public HallService(ILogger<BaseService<Model.ViewModels.Hall, Database.Hall, HallSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Hall> AddFilter(IQueryable<Database.Hall> query, HallSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.Cinema)
                    .Where(x => x.Cinema.Name.Contains(search.FTS) || x.Name.Contains(search.FTS));
            }

            if (search?.MovieId != null && search?.CinemaId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Screenings.Any(s => s.MovieId == search.MovieId) && x.CinemaId == search.CinemaId);
            }

            return filteredQuery;
        }

        public async Task<List<HallOccupancyReport>> GetHallOccupancyReportAsync(DateTime selectedDate, int cinemaId)
        {
            var result = await _context.Cinemas
                .Where(c => c.Id == cinemaId)
                .Include(c => c.Halls)
                    .ThenInclude(h => h.Seats)
                .SelectMany(c => c.Halls, (cinema, hall) => new { Cinema = cinema, Hall = hall })
                .Select(h => new HallOccupancyReport
                {
                    HallName = h.Hall.Name,
                    OccupiedSeats = h.Hall.Seats
                        .Where(s => s.BookingSeats
                            .Any(bs => bs.Booking.Screening.ScreeningTime.Date == selectedDate.Date))
                        .Count(),
                    TotalSeats = h.Hall.Seats.Count()
                })
                .ToListAsync();

            return result;
        }
    }
}

