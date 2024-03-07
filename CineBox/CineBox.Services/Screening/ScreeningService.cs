using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Screening
{
    public class ScreeningService : BaseCRUDService<Model.ViewModels.Screening, Database.Screening, ScreeningSearchObject, ScreeningInsertRequest, ScreeningUpdateRequest>, IScreeningService
    {
        public ScreeningService(ILogger<BaseService<Model.ViewModels.Screening, Database.Screening, ScreeningSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

