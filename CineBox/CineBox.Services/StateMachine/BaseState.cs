using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Services.Database;
using Microsoft.Extensions.DependencyInjection;

namespace CineBox.Services.StateMachine
{
	public class BaseState
	{
        protected IMapper _mapper { get; set; }
        protected CineBoxContext _context;
        public IServiceProvider _serviceProvider { get; set; }

        public BaseState(IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.ViewModels.Movie> Insert(MovieInsertRequest request)
		{
			throw new Exception("Not Allowed");
		}

        public virtual Task<Model.ViewModels.Movie> Update(int id, MovieUpdateRequest request)
        {
            throw new Exception("Not Allowed");
        }

        public virtual Task<Model.ViewModels.Movie> Activate(int id)
        {
            throw new Exception("Not Allowed");
        }

        public virtual Task<Model.ViewModels.Movie> Hide(int id)
        {
            throw new Exception("Not Allowed");
        }

        public virtual Task<Model.ViewModels.Movie> Delete(int id)
        {
            throw new Exception("Not Allowed");
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
                    throw new Exception("Not Allowed");
            }
        }

        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}

