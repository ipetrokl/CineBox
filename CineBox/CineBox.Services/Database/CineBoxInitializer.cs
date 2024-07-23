using System;
using Microsoft.EntityFrameworkCore;

namespace CineBox.Services.Database
{
    partial class CineBoxContext
    {
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Actor>().HasData(
                new Actor { Id = 1, Name = "Leonardo DiCaprio" },
                new Actor { Id = 2, Name = "Kate Winslet" }
            );

            modelBuilder.Entity<Genre>().HasData(
                new Genre { Id = 1, Name = "Drama" },
                new Genre { Id = 2, Name = "Action" }
            );

            modelBuilder.Entity<Cinema>().HasData(
                new Cinema { Id = 1, Name = "Cineworld", Location = "New York" },
                new Cinema { Id = 2, Name = "IMAX", Location = "Los Angeles" }
            );

            modelBuilder.Entity<Hall>().HasData(
                new Hall { Id = 1, CinemaId = 1, Name = "Hall 1" },
                new Hall { Id = 2, CinemaId = 2, Name = "Hall 2" }
            );

            modelBuilder.Entity<Movie>().HasData(
                new Movie { Id = 1, Title = "Inception", Description = "A mind-bending thriller", Director = "Christopher Nolan", GenreId = 1, PerformedFrom = new DateTime(2024, 1, 1), PerformedTo = new DateTime(2024, 12, 31) },
                new Movie { Id = 2, Title = "Titanic", Description = "A romantic disaster film", Director = "James Cameron", GenreId = 1, PerformedFrom = new DateTime(2024, 1, 1), PerformedTo = new DateTime(2024, 12, 31) }
            );

            modelBuilder.Entity<Screening>().HasData(
                new Screening { Id = 1, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 7, 24, 20, 0, 0), Category = "Standard" },
                new Screening { Id = 2, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 7, 24, 22, 0, 0), Category = "Premium" }
            );

            modelBuilder.Entity<Seat>().HasData(
                new Seat { Id = 1, HallId = 1, SeatNumber = 1, Category = "Standard", Status = true },
                new Seat { Id = 2, HallId = 1, SeatNumber = 2, Category = "Standard", Status = true },
                new Seat { Id = 3, HallId = 2, SeatNumber = 1, Category = "Premium", Status = true },
                new Seat { Id = 4, HallId = 2, SeatNumber = 2, Category = "Premium", Status = true }
            );

            modelBuilder.Entity<User>().HasData(
                new User { Id = 1, Username = "john_doe", PasswordHash = "hash1", PasswordSalt = "salt1", Email = "john@example.com", Name = "John", Surname = "Doe", Phone = "123-456-7890", Status = true },
                new User { Id = 2, Username = "jane_smith", PasswordHash = "hash2", PasswordSalt = "salt2", Email = "jane@example.com", Name = "Jane", Surname = "Smith", Phone = "987-654-3210", Status = true }
            );

            modelBuilder.Entity<Booking>().HasData(
                new Booking { Id = 1, UserId = 1, ScreeningId = 1, Price = 25.00m, PromotionId = 1 },
                new Booking { Id = 2, UserId = 2, ScreeningId = 2, Price = 30.00m, PromotionId = 1 }
            );

            modelBuilder.Entity<BookingSeat>().HasData(
                new BookingSeat { BookingSeatId = 1, BookingId = 1, SeatId = 1 },
                new BookingSeat { BookingSeatId = 2, BookingId = 1, SeatId = 2 },
                new BookingSeat { BookingSeatId = 3, BookingId = 2, SeatId = 3 },
                new BookingSeat { BookingSeatId = 4, BookingId = 2, SeatId = 4 }
            );

            modelBuilder.Entity<Ticket>().HasData(
                new Ticket { Id = 1, BookingSeatId = 1, Price = 12.50m, TicketCode = "TICKET001", QrCode = "QR001", UserId = 1 },
                new Ticket { Id = 2, BookingSeatId = 2, Price = 12.50m, TicketCode = "TICKET002", QrCode = "QR002", UserId = 1 },
                new Ticket { Id = 3, BookingSeatId = 3, Price = 15.00m, TicketCode = "TICKET003", QrCode = "QR003", UserId = 2 },
                new Ticket { Id = 4, BookingSeatId = 4, Price = 15.00m, TicketCode = "TICKET004", QrCode = "QR004", UserId = 2 }
            );

            modelBuilder.Entity<Review>().HasData(
                new Review { Id = 1, MovieId = 1, UserId = 1, Rating = 5, Comment = "Amazing movie!" },
                new Review { Id = 2, MovieId = 2, UserId = 2, Rating = 4, Comment = "Very touching film." }
            );

            modelBuilder.Entity<Promotion>().HasData(
                new Promotion { Id = 1, Code = "SUMMER20", Discount = 20.00m, ExpirationDate = new DateTime(2024, 8, 31) }
            );

            modelBuilder.Entity<Payment>().HasData(
                new Payment { Id = 1, BookingId = 1, Amount = 25.00m, PaymentStatus = "Completed" },
                new Payment { Id = 2, BookingId = 2, Amount = 30.00m, PaymentStatus = "Completed" }
            );

            modelBuilder.Entity<UsersRole>().HasData(
                new UsersRole { UsersRolesId = 1, UserId = 1, RoleId = 1, DateOfModification = DateTime.Now },
                new UsersRole { UsersRolesId = 2, UserId = 2, RoleId = 2, DateOfModification = DateTime.Now }
            );
        }
    }
}

