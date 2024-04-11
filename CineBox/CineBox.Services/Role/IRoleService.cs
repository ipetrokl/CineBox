using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Role
{
    public interface IRoleService : ICRUDService<Model.ViewModels.Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>
    {

    }
}

