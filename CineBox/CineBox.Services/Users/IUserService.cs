using System;
using CineBox.Model.Requests;
using CineBox.Model.SearchObjects;

namespace CineBox.Services.Users
{
	public interface IUserService: IService<Model.ViewModels.User, UserSearchObject>
	{
		Model.ViewModels.User Insert(UserInsertRequest request);
		Model.ViewModels.User Update(int id, UserUpdateRequest request);
	}
}

