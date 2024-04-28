using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;
using CineBox.Services;
using CineBox.Services.Database;
using CineBox.Services.Role;
using CineBox.Services.UserRole;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace CineBox.Controllers
{
    [ApiController]
    public class UsersController : BaseCRUDController<Model.ViewModels.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {

        private readonly IRoleService _roleService;
        private readonly IUsersRoleService _usersRoleService;

        public UsersController(IUserService service, IRoleService roleService, IUsersRoleService usersRoleService) : base(service)
        {
            _roleService = roleService;
            _usersRoleService = usersRoleService;
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public async Task<IActionResult> RegisterUser(UserInsertRequest userData)
        {
            var existingUser = await Get(search: new UserSearchObject { Username = userData.Username });
            if (existingUser.Count > 0)
            {
                return Conflict(new { Message = "Username already exists." });
            }

            var newUser = await Insert(userData);

            if (newUser != null)
            {
                var guestRole = await _roleService.Get(search: new RoleSearchObject { Name = "guest" });
                if (guestRole.Count == 0)
                {
                    return BadRequest(new { Message = "Role 'guest' not found." });
                }

                var usersRoleInsertRequest = new UsersRoleInsertRequest
                {
                    UserId = newUser.Id,
                    RoleId = guestRole.Result![0].Id,
                    DateOfModification = DateTime.Now
                };

                var usersRole = await _usersRoleService.Insert(usersRoleInsertRequest);
                if (usersRole == null)
                {
                    return BadRequest(new { Message = "Failed to assign role to user." });
                }

                return Ok(new { Message = "User registered successfully.", UserName = newUser.Username });
            }
            else
            {
                return BadRequest(new { Message = "Failed to register user." });
            }
        }
    }
}