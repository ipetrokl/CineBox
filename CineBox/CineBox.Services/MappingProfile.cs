using System;
using AutoMapper;
using CineBox.Model.Requests;

namespace CineBox.Services
{
	public class MappingProfile: Profile
	{
		public MappingProfile()
		{
			CreateMap<Database.User, Model.ViewModels.User>();
			CreateMap<UserInsertRequest, Database.User>();
			CreateMap<UserUpdateRequest, Database.User>();
            CreateMap<Database.UsersRole, Model.ViewModels.UsersRole>();
            CreateMap<Database.Role, Model.ViewModels.Role>();


        }
    }
}

