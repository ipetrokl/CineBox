using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Model.ViewModels;
using CineBox.Services;
using CineBox.Services.Movie;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class MovieController : BaseCRUDController<Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>
    {
        public IMovieService _movieService { get; set; }

        public MovieController(IMovieService service) : base(service)
        {
            _movieService = service;
        }

        [HttpPut("{id}/activate")]
        public virtual async Task<Movie> Activate(int id)
        {
            return await _movieService.Activate(id);
        }

        [HttpPut("{id}/hide")]
        public virtual async Task<Movie> Hide(int id)
        {
            return await _movieService.Hide(id);
        }

        [HttpPut("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await _movieService.AllowedActions(id);
        }
    }
}

