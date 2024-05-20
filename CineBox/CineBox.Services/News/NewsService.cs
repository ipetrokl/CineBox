using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Booking;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.News
{
    public class NewsService : BaseCRUDService<Model.ViewModels.News, Database.News, NewsSearchObject, NewsInsertRequest, NewsUpdateRequest>, INewsService
    {
        public NewsService(ILogger<BaseService<Model.ViewModels.News, Database.News, NewsSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.News> AddFilter(IQueryable<Database.News> query, NewsSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Where(x => x.Name.Contains(search.FTS));
            }

            return filteredQuery;
        }
    }
}

