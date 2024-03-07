using System;
using AutoMapper;
using CineBox.Model.Exceptios;
using CineBox.Model.Requests;
using CineBox.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.StateMachine
{
	public class BaseState
	{
        protected ILogger<BaseState> _logger;
        protected IMapper _mapper { get; set; }
        protected CineBoxContext _context;
        public IServiceProvider _serviceProvider { get; set; }

        public BaseState(ILogger<BaseState> logger, IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper)
        {
            _logger = logger;
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.ViewModels.Movie> Insert(MovieInsertRequest request)
		{
			throw new UserException("Not Allowed");
		}

        public virtual Task<Model.ViewModels.Movie> Update(int id, MovieUpdateRequest request)
        {
            throw new UserException("Not Allowed");
        }

        public virtual Task<Model.ViewModels.Movie> Activate(int id)
        {
            throw new UserException("Not Allowed");
        }

        public virtual Task<Model.ViewModels.Movie> Hide(int id)
        {
            throw new UserException("Not Allowed");
        }

        public virtual Task<Model.ViewModels.Movie> Delete(int id)
        {
            throw new UserException("Not Allowed");
        }

        public BaseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                case null:
                    return _serviceProvider.GetService<InitialMovieState>();
                    break;
                case "draft":
                    return _serviceProvider.GetService<DraftMovieState>();
                    break;
                case "active":
                    return _serviceProvider.GetService<ActiveMovieState>();
                    break;
                default:
                    throw new UserException("Not Allowed");
            }
        }

        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}

