using System;
using AutoMapper;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Database;
using CineBox.Services.Role;
using Microsoft.Extensions.Logging;

namespace CineBox.Services.UserRole
{
    public class UsersRoleService : BaseCRUDService<Model.ViewModels.UsersRole, Database.UsersRole, UsersRoleSearchObject, UsersRoleInsertRequest, UsersRoleUpdateRequest>, IUsersRoleService
    {
        public UsersRoleService(ILogger<BaseService<Model.ViewModels.UsersRole, Database.UsersRole, UsersRoleSearchObject>> logger, CineBoxContext context, IMapper mapper) : base(logger, context, mapper)
        {
        }
    }
}

