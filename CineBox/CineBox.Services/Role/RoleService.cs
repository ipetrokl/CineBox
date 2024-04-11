using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.Role
{
    public class RoleService : BaseCRUDService<Model.ViewModels.Role, Database.Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>, IRoleService
    {
        public RoleService(ILogger<BaseService<Model.ViewModels.Role, Database.Role, RoleSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }

        public override IQueryable<Database.Role> AddFilter(IQueryable<Database.Role> query, RoleSearchObject? search = null)
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

