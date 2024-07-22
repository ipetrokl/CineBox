using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Model.ViewModels;
using CineBox.Services.Movie;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class MovieController : BaseCRUDController<Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>
    {

        public MovieController(IMovieService service) : base(service)
        {

        }
    }
}

