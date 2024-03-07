using System;
using AutoMapper;
using CineBox.Services.Database;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.StateMachine
{
    public class ActiveMovieState : BaseState
    {
        protected ILogger<ActiveMovieState> _logger;

        public ActiveMovieState(ILogger<ActiveMovieState> logger, IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper) : base(logger, serviceProvider, context, mapper)
        {
            _logger = logger;
        }

        public override async Task<Model.ViewModels.Movie> Hide(int id)
        {
            var set = _context.Set<Database.Movie>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "draft";

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.ViewModels.Movie>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("hide");
            return list;
        }
    }
}

