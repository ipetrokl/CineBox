using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services;
using CineBox.Services.Database;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers
{
    [ApiController]
    public class UsersController : BaseCRUDController<Model.ViewModels.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {

        public UsersController(IUserService service) : base(service)
        {

        }
    }
}