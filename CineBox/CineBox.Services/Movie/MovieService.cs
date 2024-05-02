using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.StateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace CineBox.Services.Movie
{
    public class MovieService : BaseCRUDService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>, IMovieService
    {
        public BaseState _baseState { get; set; }

        public MovieService(ILogger<BaseService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject>> logger, BaseState baseState, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
            _baseState = baseState;
        }

        public override IQueryable<Database.Movie> AddFilter(IQueryable<Database.Movie> query, MovieSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Title.Contains(search.FTS) || x.Description.Contains(search.FTS));
            }

            if (!string.IsNullOrWhiteSpace(search?.Description))
            {
                filteredQuery = filteredQuery.Where(x => x.Description == search.Description);
            }

            if (search?.CinemaId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Screenings.Any(s => s.Hall.CinemaId == search.CinemaId));
            }

            return filteredQuery;
        }

        public override Task<Model.ViewModels.Movie> Insert(MovieInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");
            return state.Insert(insert);
        }

        public override async Task<Model.ViewModels.Movie> Update(int id, MovieUpdateRequest update)
        {
            var entity = await _context.Movies.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Update(id, update);
        }

        public async Task<Model.ViewModels.Movie> Activate(int id)
        {
            var entity = await _context.Movies.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Activate(id);
        }

        public async Task<Model.ViewModels.Movie> Hide(int id)
        {
            var entity = await _context.Movies.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Hide(id);
        }

        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Movies.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "initial");
            return await state.AllowedActions();
        }
    }
}

