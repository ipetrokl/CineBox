using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Actors;
using CineBox.Services.Hall;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class HallController : BaseCRUDController<Model.ViewModels.Hall, HallSearchObject, HallInsertRequest, HallUpdateRequest>
    {

        public HallController(IHallService service) : base(service)
        {

        }
    }
}

