using System;
using System.Collections.Generic;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Services.Database;

namespace CineBox.Services.StateMachine
{
	public class InitialMovieState : BaseState
	{
        public InitialMovieState(IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Model.ViewModels.Movie> Insert(MovieInsertRequest request)
        {
            var set = _context.Set<Database.Movie>();

            var entity = _mapper.Map<Database.Movie>(request);

            entity.StateMachine = "draft";

            set.Add(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.ViewModels.Movie>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("insert");

            return list;
        }
    }
}

