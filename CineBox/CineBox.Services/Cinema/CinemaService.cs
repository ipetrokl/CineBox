using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.StateMachine;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Cinema
{
    public class CinemaService : BaseCRUDService<Model.ViewModels.Cinema, Database.Cinema, CinemaSearchObject, CinemaInsertRequest, CinemaUpdateRequest>, ICinemaService
    {
        public CinemaService(ILogger<BaseService<Model.ViewModels.Cinema, Database.Cinema, CinemaSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
            
        }

        public override IQueryable<Database.Cinema> AddFilter(IQueryable<Database.Cinema> query, CinemaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(search.FTS) || x.Location.Contains(search.FTS));
            }

            if (!string.IsNullOrWhiteSpace(search?.Name))
            {
                filteredQuery = filteredQuery.Where(x => x.Name == search.Name);
            }

            return filteredQuery;
        }
    }
}

