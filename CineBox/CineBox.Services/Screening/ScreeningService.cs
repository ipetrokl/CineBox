using System;
using AutoMapper;
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

            return filteredQuery;
        }
    }
}

