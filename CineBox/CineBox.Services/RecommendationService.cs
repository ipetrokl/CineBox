using System;
using CineBox.Model.SearchObjects;
using CineBox.Services.Movie;
using CineBox.Services.Review;

namespace CineBox.Services
{
	public class RecommendationService
	{
		private readonly IMovieService _movieService;
		private readonly IReviewService _reviewService;

		public RecommendationService(IMovieService movieService, IReviewService reviewService)
		{
			_movieService = movieService;
			_reviewService = reviewService;
		}

		public List<Model.ViewModels.Movie> GetRecommendedMovies(int userId, DateTime selectedDate)
		{
            var recommendedMovies = new List<Model.ViewModels.Movie>();
            var reviewSearchObject = new ReviewSearchObject
            {
                UserId = userId
            };

            var userRatings = _reviewService.Get(reviewSearchObject).Result;

            if (userRatings.Result != null)
            {
                var filteredRatings = userRatings.Result
                    .Where(r => r.Rating >= 4)
                    .ToList();

                var genreRatings = filteredRatings
                    .GroupBy(r => r.Movie.Genre.Id)
                    .Select(g => new
                    {
                        GenreId = g.Key,
                        AverageRating = g.Average(r => r.Rating),
                        GenreName = g.FirstOrDefault()?.Movie.Genre.Name
                    })
                    .OrderByDescending(g => g.AverageRating)
                    .ToList();

                var ratedMovies = userRatings.Result
                    .Select(r => r.Movie.Id)
                    .ToHashSet();

                foreach (var genre in genreRatings)
                {
                    var movieSearchObject = new MovieSearchObject
                    {
                        GenreId = genre.GenreId,
                        SelectedDate = selectedDate
                    };

                    var moviesInGenre = _movieService.Get(movieSearchObject).Result;

                    if (moviesInGenre.Result != null)
                    {
                        var newMovies = moviesInGenre.Result
                            .Where(movie => !ratedMovies.Contains(movie.Id))
                            .ToList();

                        recommendedMovies.AddRange(newMovies);
                    }
                }
            }

            return recommendedMovies.ToList();
        }
	}
}

