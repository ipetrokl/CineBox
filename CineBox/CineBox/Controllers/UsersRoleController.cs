using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.UserRole;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class UsersRoleController : BaseCRUDController<Model.ViewModels.UsersRole, UsersRoleSearchObject, UsersRoleInsertRequest, UsersRoleUpdateRequest>
    {

        public UsersRoleController(IUsersRoleService service) : base(service)
        {

        }
    }
}

