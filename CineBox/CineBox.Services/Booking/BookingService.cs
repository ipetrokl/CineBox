using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Booking
{
    public class BookingService : BaseCRUDService<Model.ViewModels.Booking, Database.Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>, IBookingService
    {
        public BookingService(ILogger<BaseService<Model.ViewModels.Booking, Database.Booking, BookingSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Booking> AddFilter(IQueryable<Database.Booking> query, BookingSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.User)
                    .Include(x => x.Screening)
                    .Where(x => x.User.Name.Contains(search.FTS) || x.Screening.Hall.Name.Contains(search.FTS));
            }

            if (search?.ScreeningId != null)
            {
                filteredQuery = filteredQuery
                    .Where(x => x.ScreeningId == search.ScreeningId);
            }

            return filteredQuery;
        }

        public override IQueryable<Database.Booking> AddInclude(IQueryable<Database.Booking> query, BookingSearchObject? search = null)
        {
            return query
                 .Include(x => x.Screening)
                    .ThenInclude(y => y.Movie)
                 .Include(x => x.Promotion);

        }
    }
}

