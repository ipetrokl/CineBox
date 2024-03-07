using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Actors;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class ActorController : BaseCRUDController<Model.ViewModels.Actor, ActorSearchObject, ActorInsertRequest, ActorUpdateRequest>
    {

        public ActorController(IActorService service) : base(service)
        {

        }
    }
}

