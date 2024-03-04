﻿using System;
using AutoMapper;
using Azure.Core;
using CineBox.Model.Requests;
using CineBox.Services.Database;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace CineBox.Services.StateMachine
{
    public class DraftMovieState : BaseState
    {
        public DraftMovieState(IServiceProvider serviceProvider, CineBoxContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Model.ViewModels.Movie> Update(int id, MovieUpdateRequest request)
        {
            var set = _context.Set<Database.Movie>();

            var entity = await set.FindAsync(id);

            _mapper.Map(request, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.ViewModels.Movie>(entity);
        }

        public override async Task<Model.ViewModels.Movie> Activate(int id)
        {
            var set = _context.Set<Database.Movie>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.ViewModels.Movie>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("update");
            list.Add("activate");
            return list;
        }
    }
}

