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
    protected IUserService _userService;

    public UsersController(IUserService service) : base(service)
    {
        _userService = service;
    }

    [HttpPost]
    public Model.ViewModels.User Insert(UserInsertRequest request)
    {
        return _userService.Insert(request);
    }

    [HttpPut("{id}")]
    public Model.ViewModels.User Update(int id, UserUpdateRequest request)
    {
        return _userService.Update(id, request);
    }
}

