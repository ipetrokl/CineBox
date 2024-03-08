using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Review
{
    public class ReviewService : BaseCRUDService<Model.ViewModels.Review, Database.Review, ReviewSearchObject, ReviewInsertRequest, ReviewUpdateRequest>, IReviewService
    {
        public ReviewService(ILogger<BaseService<Model.ViewModels.Review, Database.Review, ReviewSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

