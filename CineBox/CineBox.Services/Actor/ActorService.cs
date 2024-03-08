using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Actor
{
    public class ActorService : BaseCRUDService<Model.ViewModels.Actor, Database.Actor, ActorSearchObject, ActorInsertRequest, ActorUpdateRequest>, IActorService
    {
        public ActorService(ILogger<BaseService<Model.ViewModels.Actor, Database.Actor, ActorSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

