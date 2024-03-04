using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.StateMachine;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace CineBox.Services.Movie
{
    public class MovieService : BaseCRUDService<Model.ViewModels.Movie, Database.Movie, MovieSearchObject, MovieInsertRequest, MovieUpdateRequest>, IMovieService
    {
        public BaseState _baseState { get; set; }

        public MovieService(BaseState baseState, CineBoxContext context, IMapper mapper) : base(context, mapper)
        {
            _baseState = baseState;
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

