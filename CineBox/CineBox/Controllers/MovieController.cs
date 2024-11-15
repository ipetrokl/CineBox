﻿using System;
using CineBox.Model.Reports;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Model.ViewModels;
using CineBox.Services;
using CineBox.Services.Movie;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class MovieController : BaseCRUDController<Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>
    {
        private readonly RecommendationService _recommendationService;
        private readonly IMovieService _movieService;

        public MovieController(IMovieService service, RecommendationService recommendationService) : base(service)
        {
            _recommendationService = recommendationService;
            _movieService = service;
        }

        [HttpGet("GetRecommendedMovies/{userId}/{selectedDate}")]
        public ActionResult<List<Movie>> RecommendedMovies(int userId, DateTime selectedDate)
        {
            var recommendedMovies = _recommendationService.GetRecommendedMovies(userId, selectedDate);
            return recommendedMovies;
        }

        [HttpGet("popularity")]
        public async Task<List<MoviePopularityReport>> GetTopBookedMoviesAsync()
        {
            return await _movieService.GetTopBookedMoviesAsync();
        }
    }
}

