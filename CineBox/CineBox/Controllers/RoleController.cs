using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services.Role;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class RoleController : BaseCRUDController<Model.ViewModels.Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>
    {

        public RoleController(IRoleService service) : base(service)
        {

        }
    }
}

