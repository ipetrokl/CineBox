using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Genre;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class GenreController : BaseCRUDController<Model.ViewModels.Genre, GenreSearchObject, GenreInsertRequest, GenreUpdateRequest>
    {

        public GenreController(IGenreService service) : base(service)
        {

        }
    }
}

