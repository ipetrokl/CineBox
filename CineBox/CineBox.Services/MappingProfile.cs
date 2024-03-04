using System;
using AutoMapper;
using CineBox.Model.Requests;

namespace CineBox.Services
{
	public class MappingProfile: Profile
	{
		public MappingProfile()
		{
			//User
			CreateMap<Database.User, Model.ViewModels.User>();
			CreateMap<UserInsertRequest, Database.User>();
			CreateMap<UserUpdateRequest, Database.User>();
			//Roles
            CreateMap<Database.UsersRole, Model.ViewModels.UsersRole>();
            CreateMap<Database.Role, Model.ViewModels.Role>();
			//Movie
			CreateMap<Database.Movie, Model.ViewModels.Movie>();
            CreateMap<MovieInsertRequest, Database.Movie>();
            CreateMap<MovieUpdateRequest, Database.Movie>();


        }
    }
}

