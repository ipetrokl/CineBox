using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Seat
{
    public class SeatService : BaseCRUDService<Model.ViewModels.Seat, Database.Seat, SeatSearchObject, SeatInsertRequest, SeatUpdateRequest>, ISeatService
    {
        public SeatService(ILogger<BaseService<Model.ViewModels.Seat, Database.Seat, SeatSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Seat> AddFilter(IQueryable<Database.Seat> query, SeatSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.Hall)
                    .Where(x => x.Hall.Name.Contains(search.FTS) || x.Category.Contains(search.FTS));
            }

            return filteredQuery;
        }
    }
}