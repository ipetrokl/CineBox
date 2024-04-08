using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace CineBox.Services.Database;

public partial class CineBoxContext : DbContext
{
    public CineBoxContext()
    {
    }

    public CineBoxContext(DbContextOptions<CineBoxContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Actor> Actors { get; set; }

    public virtual DbSet<Booking> Bookings { get; set; }

    public virtual DbSet<BookingSeat> BookingSeats { get; set; }

    public virtual DbSet<Cinema> Cinemas { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Hall> Halls { get; set; }

    public virtual DbSet<Movie> Movies { get; set; }

    public virtual DbSet<MovieActor> MovieActors { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<Promotion> Promotions { get; set; }

    public virtual DbSet<PromotionBooking> PromotionBookings { get; set; }

    public virtual DbSet<Review> Reviews { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Screening> Screenings { get; set; }

    public virtual DbSet<Seat> Seats { get; set; }

    public virtual DbSet<Ticket> Tickets { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UsersRole> UsersRoles { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Actor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Actor__3213E83FC0FEE5A5");

            entity.ToTable("Actor");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Booking>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Booking__3213E83F17342E3F");

            entity.ToTable("Booking");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("price");
            entity.Property(e => e.ScreeningId).HasColumnName("screening_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Screening).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.ScreeningId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Booking__screeni__4AB81AF0");

            entity.HasOne(d => d.User).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Booking__user_id__49C3F6B7");
        });

        modelBuilder.Entity<BookingSeat>(entity =>
        {
            entity.HasKey(e => e.BookingSeatId).HasName("PK__BookingS__0F3B47D6073D2EA9");

            entity.ToTable("BookingSeat");

            entity.Property(e => e.BookingSeatId).HasColumnName("bookingSeatId");
            entity.Property(e => e.BookingId).HasColumnName("booking_id");
            entity.Property(e => e.SeatId).HasColumnName("seat_id");

            entity.HasOne(d => d.Booking).WithMany(p => p.BookingSeats)
                .HasForeignKey(d => d.BookingId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__BookingSe__booki__6477ECF3");

            entity.HasOne(d => d.Seat).WithMany(p => p.BookingSeats)
                .HasForeignKey(d => d.SeatId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__BookingSe__seat___656C112C");
        });

        modelBuilder.Entity<Cinema>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Cinema__3213E83F727DA539");

            entity.ToTable("Cinema");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Location)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("location");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Genre__3213E83F6E5E8F5B");

            entity.ToTable("Genre");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Hall>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Hall__3213E83F55555B66");

            entity.ToTable("Hall");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CinemaId).HasColumnName("cinema_id");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("name");

            entity.HasOne(d => d.Cinema).WithMany(p => p.Halls)
                .HasForeignKey(d => d.CinemaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Hall__cinema_id__5CD6CB2B");
        });

        modelBuilder.Entity<Movie>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Movie__3213E83F5811C8AC");

            entity.ToTable("Movie");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.Director)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("director");
            entity.Property(e => e.Duration).HasColumnName("duration");
            entity.Property(e => e.GenreId).HasColumnName("genre_id");
            entity.Property(e => e.Picture).HasColumnName("picture");
            entity.Property(e => e.PictureThumb).HasColumnName("pictureThumb");
            entity.Property(e => e.ReleaseDate)
                .HasColumnType("date")
                .HasColumnName("release_date");
            entity.Property(e => e.StateMachine)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("stateMachine");
            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("title");

            entity.HasOne(d => d.Genre).WithMany(p => p.Movies)
                .HasForeignKey(d => d.GenreId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Movie__genre_id__412EB0B6");
        });

        modelBuilder.Entity<MovieActor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__MovieAct__3213E83FE72A9DEF");

            entity.ToTable("MovieActor");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.ActorId).HasColumnName("actor_id");
            entity.Property(e => e.MovieId).HasColumnName("movie_id");

            entity.HasOne(d => d.Actor).WithMany(p => p.MovieActors)
                .HasForeignKey(d => d.ActorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__MovieActo__actor__59FA5E80");

            entity.HasOne(d => d.Movie).WithMany(p => p.MovieActors)
                .HasForeignKey(d => d.MovieId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__MovieActo__movie__59063A47");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Payment__3213E83F0302F6C4");

            entity.ToTable("Payment");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.BookingId).HasColumnName("booking_id");
            entity.Property(e => e.PaymentStatus)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("payment_status");

            entity.HasOne(d => d.Booking).WithMany(p => p.Payments)
                .HasForeignKey(d => d.BookingId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Payment__booking__5070F446");
        });

        modelBuilder.Entity<Promotion>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Promotio__3213E83F3E391388");

            entity.ToTable("Promotion");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Code)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("code");
            entity.Property(e => e.Discount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("discount");
            entity.Property(e => e.ExpirationDate)
                .HasColumnType("date")
                .HasColumnName("expiration_date");
        });

        modelBuilder.Entity<PromotionBooking>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Promotio__3213E83FBBB10A35");

            entity.ToTable("PromotionBooking");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BookingId).HasColumnName("booking_id");
            entity.Property(e => e.PromotionId).HasColumnName("promotion_id");

            entity.HasOne(d => d.Booking).WithMany(p => p.PromotionBookings)
                .HasForeignKey(d => d.BookingId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Promotion__booki__693CA210");

            entity.HasOne(d => d.Promotion).WithMany(p => p.PromotionBookings)
                .HasForeignKey(d => d.PromotionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Promotion__promo__68487DD7");
        });

        modelBuilder.Entity<Review>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Review__3213E83FE5CB41C2");

            entity.ToTable("Review");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Comment)
                .IsUnicode(false)
                .HasColumnName("comment");
            entity.Property(e => e.MovieId).HasColumnName("movie_id");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Movie).WithMany(p => p.Reviews)
                .HasForeignKey(d => d.MovieId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Review__movie_id__5441852A");

            entity.HasOne(d => d.User).WithMany(p => p.Reviews)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Review__user_id__534D60F1");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Roles__3213E83F5E3437B4");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Descripotion)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("descripotion");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Screening>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Screenin__3213E83F7DDCC654");

            entity.ToTable("Screening");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Category)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("category");
            entity.Property(e => e.CinemaId).HasColumnName("cinema_id");
            entity.Property(e => e.EndTime)
                .HasColumnType("datetime")
                .HasColumnName("end_time");
            entity.Property(e => e.MovieId).HasColumnName("movie_id");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("price");
            entity.Property(e => e.StartTime)
                .HasColumnType("datetime")
                .HasColumnName("start_time");

            entity.HasOne(d => d.Cinema).WithMany(p => p.Screenings)
                .HasForeignKey(d => d.CinemaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Screening__cinem__46E78A0C");

            entity.HasOne(d => d.Movie).WithMany(p => p.Screenings)
                .HasForeignKey(d => d.MovieId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Screening__movie__45F365D3");
        });

        modelBuilder.Entity<Seat>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Seat__3213E83F577DFD43");

            entity.ToTable("Seat");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Category)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("category");
            entity.Property(e => e.HallId).HasColumnName("hall_id");
            entity.Property(e => e.SeatNumber).HasColumnName("seat_number");
            entity.Property(e => e.Status)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasOne(d => d.Hall).WithMany(p => p.Seats)
                .HasForeignKey(d => d.HallId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Seat__hall_id__5FB337D6");
        });

        modelBuilder.Entity<Ticket>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Ticket__3213E83F59CAD11F");

            entity.ToTable("Ticket");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BookingId).HasColumnName("booking_id");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("price");
            entity.Property(e => e.QrCode)
                .IsUnicode(false)
                .HasColumnName("qr_code");
            entity.Property(e => e.TicketCode)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("ticket_code");

            entity.HasOne(d => d.Booking).WithMany(p => p.Tickets)
                .HasForeignKey(d => d.BookingId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Ticket__booking___4D94879B");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__User__3213E83F6C1ABB42");

            entity.ToTable("User");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("passwordHash");
            entity.Property(e => e.PasswordSalt)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("passwordSalt");
            entity.Property(e => e.Phone)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("phone");
            entity.Property(e => e.Surname)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("surname");
            entity.Property(e => e.Username)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("username");
        });

        modelBuilder.Entity<UsersRole>(entity =>
        {
            entity.HasKey(e => e.UsersRolesId).HasName("PK__UsersRol__A9752347F5D2A3F4");

            entity.Property(e => e.DateOfModification)
                .HasColumnType("datetime")
                .HasColumnName("dateOfModification");
            entity.Property(e => e.RoleId).HasColumnName("role_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity.HasOne(d => d.Role).WithMany(p => p.UsersRoles)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__UsersRole__role___3C69FB99");

            entity.HasOne(d => d.User).WithMany(p => p.UsersRoles)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__UsersRole__user___3B75D760");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
