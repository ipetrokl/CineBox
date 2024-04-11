using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Genre
{
    public class GenreService : BaseCRUDService<Model.ViewModels.Genre, Database.Genre, GenreSearchObject, GenreInsertRequest, GenreUpdateRequest>, IGenreService
    {
        public GenreService(ILogger<BaseService<Model.ViewModels.Genre, Database.Genre, GenreSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Genre> AddFilter(IQueryable<Database.Genre> query, GenreSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery
                    .Where(x => x.Name.Contains(search.FTS));
            }

            return filteredQuery;
        }
    }
}

