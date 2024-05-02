using System;
using AutoMapper;
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

            if (search?.MovieId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Screenings.Any(s => s.MovieId == search.MovieId));
            }

            return filteredQuery;
        }
    }
}

