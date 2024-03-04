using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services;
using CineBox.Services.Database;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers;

[ApiController]
public class UsersController : BaseController<Model.ViewModels.User, UserSearchObject>
{
    public UsersController(IUserService service) : base(service)
    {
    }

    //[HttpPost]
    //public Model.ViewModels.User Insert(UserInsertRequest request)
    //{
    //    return _service.Insert(request);
    //}

    //[HttpPut("{id}")]
    //public Model.ViewModels.User Update(int id, UserUpdateRequest request)
    //{
    //    return _service.Update(id, request);
    //}
}

