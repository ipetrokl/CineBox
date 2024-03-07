using System;
using System.Collections.Generic;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.StateMachine
{
	public class InitialMovieState : BaseState
	{
        protected ILogger<InitialMovieState> _logger;

        public InitialMovieState(ILogger<InitialMovieState> logger, IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper) : base(logger, serviceProvider, context, mapper)
        {
            _logger = logger;
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

