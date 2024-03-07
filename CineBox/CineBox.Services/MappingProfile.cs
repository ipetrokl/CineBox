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
            //Cinema
            CreateMap<Database.Cinema, Model.ViewModels.Cinema>();
            CreateMap<CinemaInsertRequest, Database.Cinema>();
            CreateMap<CinemaUpdateRequest, Database.Cinema>();
            //Screening
            CreateMap<Database.Screening, Model.ViewModels.Screening>();
            CreateMap<ScreeningInsertRequest, Database.Screening>();
            CreateMap<ScreeningUpdateRequest, Database.Screening>();
            //Genre
            CreateMap<Database.Genre, Model.ViewModels.Genre>();
            CreateMap<GenreInsertRequest, Database.Genre>();
            CreateMap<GenreUpdateRequest, Database.Genre>();
            //Actor
            CreateMap<Database.Actor, Model.ViewModels.Actor>();
            CreateMap<ActorInsertRequest, Database.Actor>();
            CreateMap<ActorUpdateRequest, Database.Actor>();
            //Hall
            CreateMap<Database.Hall, Model.ViewModels.Hall>();
            CreateMap<HallInsertRequest, Database.Hall>();
            CreateMap<HallUpdateRequest, Database.Hall>();

        }
    }
}

