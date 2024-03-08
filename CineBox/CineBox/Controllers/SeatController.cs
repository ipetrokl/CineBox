using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Seat;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class SeatController : BaseCRUDController<Model.ViewModels.Seat, SeatSearchObject, SeatInsertRequest, SeatUpdateRequest>
    {

        public SeatController(ISeatService service) : base(service)
        {

        }
    }
}

