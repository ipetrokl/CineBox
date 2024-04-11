using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.UserRole
{
    public interface IUsersRoleService : ICRUDService<Model.ViewModels.UsersRole, UsersRoleSearchObject, UsersRoleInsertRequest, UsersRoleUpdateRequest>
    {

    }
}

