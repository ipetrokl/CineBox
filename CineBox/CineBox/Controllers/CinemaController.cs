using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Cinema;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class CinemaController : BaseCRUDController<Model.ViewModels.Cinema, CinemaSearchObject, CinemaInsertRequest, CinemaUpdateRequest>
    {

        public CinemaController(ICinemaService service) : base(service)
        {

        }
    }
}

