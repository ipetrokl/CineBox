using CineBox.Filters;
using CineBox.Services.Actors;
using CineBox.Services.Booking;
using CineBox.Services.BookingSeat;
using CineBox.Services.Cinema;
using CineBox.Services.Database;
using CineBox.Services.Genre;
using CineBox.Services.Hall;
using CineBox.Services.Movie;
using CineBox.Services.Payment;
using CineBox.Services.Promotion;
using CineBox.Services.Screening;
using CineBox.Services.Seat;
using CineBox.Services.StateMachine;
using CineBox.Services.Ticket;
using CineBox.Services.Users;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IMovieService, MovieService>();
builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialMovieState>();
builder.Services.AddTransient<DraftMovieState>();
builder.Services.AddTransient<ActiveMovieState>();
builder.Services.AddTransient<ICinemaService, CinemaService>();
builder.Services.AddTransient<IScreeningService, ScreeningService>();
builder.Services.AddTransient<IGenreService, GenreService>();
builder.Services.AddTransient<IActorService, ActorService>();
builder.Services.AddTransient<IHallService, HallService>();
builder.Services.AddTransient<ISeatService, SeatService>();
builder.Services.AddTransient<IPromotionService, PromotionService>();
builder.Services.AddTransient<IBookingSeatService, BookingSeatService>();
builder.Services.AddTransient<IBookingService, BookingService>();
builder.Services.AddTransient<ITicketService, TicketService>();
builder.Services.AddTransient<IPaymentService, PaymentService>();


builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<CineBoxContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IUserService));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

