using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Promotion
{
    public class PromotionService : BaseCRUDService<Model.ViewModels.Promotion, Database.Promotion, PromotionSearchObject, PromotionInsertRequest, PromotionUpdateRequest>, IPromotionService
    {
        public PromotionService(ILogger<BaseService<Model.ViewModels.Promotion, Database.Promotion, PromotionSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

