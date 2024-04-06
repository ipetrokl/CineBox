using CineBox;
using CineBox.Filters;
using CineBox.Services;
using CineBox.Services.Actor;
using CineBox.Services.Booking;
using CineBox.Services.BookingSeat;
using CineBox.Services.Cinema;
using CineBox.Services.Database;
using CineBox.Services.Genre;
using CineBox.Services.Hall;
using CineBox.Services.Movie;
using CineBox.Services.MovieActor;
using CineBox.Services.Payment;
using CineBox.Services.Promotion;
using CineBox.Services.Review;
using CineBox.Services.Screening;
using CineBox.Services.Seat;
using CineBox.Services.StateMachine;
using CineBox.Services.Ticket;
using CineBox.Services.Users;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

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
builder.Services.AddTransient<IReviewService, ReviewService>();
builder.Services.AddTransient<IMovieActorService, MovieActorService>();


builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen( c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
            },
            new String[]{}
        }
    });
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<CineBoxContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(MappingProfile));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<CineBoxContext>();
    //dataContext.Database.EnsureCreated();
    //dataContext.Database.Migrate();
}

app.Run();

