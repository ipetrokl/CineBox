using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.MovieActor;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class MovieActorController : BaseCRUDController<Model.ViewModels.MovieActor, MovieActorSearchObject, MovieActorInsertRequest, MovieActorUpdateRequest>
    {

        public MovieActorController(IMovieActorService service) : base(service)
        {

        }
    }
}

