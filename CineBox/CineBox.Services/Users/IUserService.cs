using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Users
{
	public interface IUserService: ICRUDService<Model.ViewModels.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
	{
		public Task<Model.ViewModels.User> Login(string username, string password);
	}
}

