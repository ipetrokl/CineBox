using System;
using CineBox.Model.Requests;

namespace CineBox.Services.Users
{
	public interface IUserService
	{
		List<Model.ViewModels.User> Get();
		Model.ViewModels.User Insert(UserInsertRequest request);
		Model.ViewModels.User Update(int id, UserUpdateRequest request);
	}
}

