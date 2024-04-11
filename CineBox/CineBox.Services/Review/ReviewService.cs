using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Review
{
    public class ReviewService : BaseCRUDService<Model.ViewModels.Review, Database.Review, ReviewSearchObject, ReviewInsertRequest, ReviewUpdateRequest>, IReviewService
    {
        public ReviewService(ILogger<BaseService<Model.ViewModels.Review, Database.Review, ReviewSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Review> AddFilter(IQueryable<Database.Review> query, ReviewSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.User)
                    .Where(x => x.User.Name.Contains(search.FTS) || x.User.Username.Contains(search.FTS) || x.Comment.Contains(search.FTS));
            }

            return filteredQuery;
        }
    }
}

