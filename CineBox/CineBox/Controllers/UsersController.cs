using CineBox.Model.Requests;
using CineBox.Services.Database;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Mvc;

namespace CineBox.Controllers;

[ApiController]
[Route("[controller]")]
public class UsersController : ControllerBase
{
    private readonly IUserService _service;

    public UsersController(IUserService service)
    {
        _service = service;
    }

    [HttpGet()]
    public IEnumerable<Model.ViewModels.User> Get()
    {
        return _service.Get();
    }

    [HttpPost]
    public Model.ViewModels.User Insert(UserInsertRequest request)
    {
        return _service.Insert(request);
    }

    [HttpPut("{id}")]
    public Model.ViewModels.User Update(int id, UserUpdateRequest request)
    {
        return _service.Update(id, request);
    }
}

