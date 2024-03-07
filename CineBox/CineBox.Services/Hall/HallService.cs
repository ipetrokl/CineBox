using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Hall
{
    public class HallService : BaseCRUDService<Model.ViewModels.Hall, Database.Hall, HallSearchObject, HallInsertRequest, HallUpdateRequest>, IHallService
    {
        public HallService(ILogger<BaseService<Model.ViewModels.Hall, Database.Hall, HallSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

