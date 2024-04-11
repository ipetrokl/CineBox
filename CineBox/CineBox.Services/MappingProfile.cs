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
            //Seat
            CreateMap<Database.Seat, Model.ViewModels.Seat>();
            CreateMap<SeatInsertRequest, Database.Seat>();
            CreateMap<SeatUpdateRequest, Database.Seat>();
            //Promotion
            CreateMap<Database.Promotion, Model.ViewModels.Promotion>();
            CreateMap<PromotionInsertRequest, Database.Promotion>();
            CreateMap<PromotionUpdateRequest, Database.Promotion>();
            //BookingSeat
            CreateMap<Database.BookingSeat, Model.ViewModels.BookingSeat>();
            CreateMap<BookingSeatInsertRequest, Database.BookingSeat>();
            CreateMap<BookingSeatUpdateRequest, Database.BookingSeat>();
            //Booking
            CreateMap<Database.Booking, Model.ViewModels.Booking>();
            CreateMap<BookingInsertRequest, Database.Booking>();
            CreateMap<BookingUpdateRequest, Database.Booking>();
            //Ticket
            CreateMap<Database.Ticket, Model.ViewModels.Ticket>();
            CreateMap<TicketInsertRequest, Database.Ticket>();
            CreateMap<TicketUpdateRequest, Database.Ticket>();
            //Payment
            CreateMap<Database.Payment, Model.ViewModels.Payment>();
            CreateMap<PaymentInsertRequest, Database.Payment>();
            CreateMap<PaymentUpdateRequest, Database.Payment>();
            //Review
            CreateMap<Database.Review, Model.ViewModels.Review>();
            CreateMap<ReviewInsertRequest, Database.Review>();
            CreateMap<ReviewUpdateRequest, Database.Review>();
            //MovieActor
            CreateMap<Database.MovieActor, Model.ViewModels.MovieActor>();
            CreateMap<MovieActorInsertRequest, Database.MovieActor>();
            CreateMap<MovieActorUpdateRequest, Database.MovieActor>();
            //Role
            CreateMap<Database.Role, Model.ViewModels.Role>();
            CreateMap<RoleInsertRequest, Database.Role>();
            CreateMap<RoleUpdateRequest, Database.Role>();
            //UsersRole
            CreateMap<Database.UsersRole, Model.ViewModels.UsersRole>();
            CreateMap<UsersRoleInsertRequest, Database.UsersRole>();
            CreateMap<UsersRoleUpdateRequest, Database.UsersRole>();

        }
    }
}

