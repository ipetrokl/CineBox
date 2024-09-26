using System;
using System.Drawing;
using CineBox.Services.Helper;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Microsoft.EntityFrameworkCore;

namespace CineBox.Services.Database
{
    partial class CineBoxContext
    {
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new User { Id = 1, Username = "test", PasswordHash = "6YN5P1X5LBm8BrXPRbgxo9gOhRc=", PasswordSalt = "AE9YsGCoSj4H1vy1RUHkng==", Email = "cineboxpetrovic@gmail.com", Name = "John", Surname = "Doe", Phone = "123-456-7890", Status = true },
                new User { Id = 2, Username = "guest", PasswordHash = "CX9GC3inZ7AA7itor/taR6ozGQM=", PasswordSalt = "YzSwhwHPu3+++d+LsG4kiA==", Email = "jane@example.com", Name = "Jane", Surname = "Smith", Phone = "987-654-3210", Status = true },
                new User { Id = 3, Username = "support", PasswordHash = "6YN5P1X5LBm8BrXPRbgxo9gOhRc=", PasswordSalt = "AE9YsGCoSj4H1vy1RUHkng==", Email = "cinebox20244@gmail.com", Name = "cinebox20244@gmail.com", Surname = "xwiyktjxrcswohoa", Phone = "987-654-3210", Status = true }
            );

            modelBuilder.Entity<Role>().HasData(
                new Role { Id = 1, Name = "admin", Description = "admin" },
                new Role { Id = 2, Name = "guest", Description = "guest" }
            );

            modelBuilder.Entity<UsersRole>().HasData(
                new UsersRole { UsersRolesId = 1, UserId = 1, RoleId = 1, DateOfModification = DateTime.Now },
                new UsersRole { UsersRolesId = 2, UserId = 2, RoleId = 2, DateOfModification = DateTime.Now }
            );

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
                new Hall { Id = 2, CinemaId = 1, Name = "Hall 2" },
                new Hall { Id = 3, CinemaId = 1, Name = "Hall 3" },
                new Hall { Id = 4, CinemaId = 2, Name = "Hall 1" },
                new Hall { Id = 5, CinemaId = 2, Name = "Hall 2" },
                new Hall { Id = 6, CinemaId = 2, Name = "Hall 3" }
            );

            var img = PictureHelper.ConvertImageToByteArray("SeedImages/Titanic.png");

            modelBuilder.Entity<Picture>().HasData(
                new Picture { Id = 1, Picture1 = img }
            );

            modelBuilder.Entity<Movie>().HasData(
                new Movie { Id = 1, Title = "Inception", Description = "A mind-bending thriller", Director = "Christopher Nolan", GenreId = 1, PerformedFrom = new DateTime(2024, 09, 25), PerformedTo = new DateTime(2024, 10, 31), PictureId = 1 },
                new Movie { Id = 2, Title = "Titanic", Description = "A romantic disaster film", Director = "James Cameron", GenreId = 1, PerformedFrom = new DateTime(2024, 09, 25), PerformedTo = new DateTime(2024, 10, 31), PictureId = 1 },
                new Movie { Id = 3, Title = "Test1", Description = "Test1", Director = "James Cameron", GenreId = 1, PerformedFrom = new DateTime(2024, 09, 25), PerformedTo = new DateTime(2024, 10, 31), PictureId = 1 },
                new Movie { Id = 4, Title = "Test2", Description = "Test2", Director = "James Cameron", GenreId = 2, PerformedFrom = new DateTime(2024, 09, 25), PerformedTo = new DateTime(2024, 10, 31), PictureId = 1 }
            );

            modelBuilder.Entity<MovieActor>().HasData(
                new MovieActor { Id = 1, MovieId = 1, ActorId = 1 },
                new MovieActor { Id = 2, MovieId = 2, ActorId = 2 }
            );

            modelBuilder.Entity<Screening>().HasData(
                //Cinema1
                new Screening { Id = 1, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 2, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 2, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 2, 22, 0, 0), Category = "3D" },
                new Screening { Id = 3, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 2, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 4, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 2, 19, 0, 0), Category = "3D" },
                new Screening { Id = 5, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 3, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 6, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 3, 22, 0, 0), Category = "3D" },
                new Screening { Id = 7, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 3, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 8, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 3, 19, 0, 0), Category = "3D" },
                new Screening { Id = 9, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 4, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 10, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 4, 22, 0, 0), Category = "3D" },
                new Screening { Id = 11, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 4, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 12, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 4, 19, 0, 0), Category = "3D" },
                new Screening { Id = 13, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 5, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 14, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 5, 22, 0, 0), Category = "3D" },
                new Screening { Id = 15, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 5, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 16, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 5, 19, 0, 0), Category = "3D" },
                new Screening { Id = 17, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 6, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 18, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 6, 22, 0, 0), Category = "3D" },
                new Screening { Id = 19, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 6, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 20, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 6, 19, 0, 0), Category = "3D" },
                new Screening { Id = 21, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 7, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 22, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 7, 22, 0, 0), Category = "3D" },
                new Screening { Id = 23, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 7, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 24, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 7, 19, 0, 0), Category = "3D" },
                new Screening { Id = 25, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 8, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 26, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 8, 22, 0, 0), Category = "3D" },
                new Screening { Id = 27, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 8, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 28, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 8, 19, 0, 0), Category = "3D" },
                new Screening { Id = 29, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 9, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 30, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 9, 22, 0, 0), Category = "3D" },
                new Screening { Id = 31, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 9, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 32, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 9, 19, 0, 0), Category = "3D" },
                new Screening { Id = 33, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 10, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 34, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 10, 22, 0, 0), Category = "3D" },
                new Screening { Id = 35, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 10, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 36, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 10, 19, 0, 0), Category = "3D" },
                new Screening { Id = 37, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 11, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 38, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 11, 22, 0, 0), Category = "3D" },
                new Screening { Id = 39, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 11, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 40, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 11, 19, 0, 0), Category = "3D" },
                new Screening { Id = 41, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 12, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 42, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 12, 22, 0, 0), Category = "3D" },
                new Screening { Id = 43, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 12, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 44, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 12, 19, 0, 0), Category = "3D" },
                new Screening { Id = 45, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 13, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 46, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 13, 22, 0, 0), Category = "3D" },
                new Screening { Id = 47, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 13, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 48, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 13, 19, 0, 0), Category = "3D" },
                new Screening { Id = 49, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 14, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 50, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 14, 22, 0, 0), Category = "3D" },
                new Screening { Id = 51, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 14, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 52, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 14, 19, 0, 0), Category = "3D" },
                new Screening { Id = 53, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 15, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 54, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 15, 22, 0, 0), Category = "3D" },
                new Screening { Id = 55, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 15, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 56, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 15, 19, 0, 0), Category = "3D" },
                new Screening { Id = 57, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 16, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 58, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 16, 22, 0, 0), Category = "3D" },
                new Screening { Id = 59, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 16, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 60, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 16, 19, 0, 0), Category = "3D" },
                new Screening { Id = 61, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 17, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 62, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 17, 22, 0, 0), Category = "3D" },
                new Screening { Id = 63, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 17, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 64, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 17, 19, 0, 0), Category = "3D" },
                new Screening { Id = 65, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 18, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 66, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 18, 22, 0, 0), Category = "3D" },
                new Screening { Id = 67, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 18, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 68, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 18, 19, 0, 0), Category = "3D" },
                new Screening { Id = 69, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 19, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 70, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 19, 22, 0, 0), Category = "3D" },
                new Screening { Id = 71, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 19, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 72, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 19, 19, 0, 0), Category = "3D" },
                new Screening { Id = 73, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 20, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 74, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 20, 22, 0, 0), Category = "3D" },
                new Screening { Id = 75, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 20, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 76, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 20, 19, 0, 0), Category = "3D" },
                new Screening { Id = 77, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 21, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 78, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 21, 22, 0, 0), Category = "3D" },
                new Screening { Id = 79, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 21, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 80, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 21, 19, 0, 0), Category = "3D" },
                new Screening { Id = 81, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 22, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 82, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 22, 22, 0, 0), Category = "3D" },
                new Screening { Id = 83, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 22, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 84, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 22, 19, 0, 0), Category = "3D" },
                new Screening { Id = 85, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 23, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 86, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 23, 22, 0, 0), Category = "3D" },
                new Screening { Id = 87, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 23, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 88, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 23, 19, 0, 0), Category = "3D" },
                new Screening { Id = 89, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 24, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 90, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 24, 22, 0, 0), Category = "3D" },
                new Screening { Id = 91, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 24, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 92, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 24, 19, 0, 0), Category = "3D" },
                new Screening { Id = 93, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 25, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 94, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 25, 22, 0, 0), Category = "3D" },
                new Screening { Id = 95, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 25, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 96, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 25, 19, 0, 0), Category = "3D" },
                new Screening { Id = 97, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 26, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 98, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 26, 22, 0, 0), Category = "3D" },
                new Screening { Id = 99, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 26, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 100, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 26, 19, 0, 0), Category = "3D" },
                new Screening { Id = 101, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 27, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 102, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 27, 22, 0, 0), Category = "3D" },
                new Screening { Id = 103, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 27, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 104, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 27, 19, 0, 0), Category = "3D" },
                new Screening { Id = 105, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 28, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 106, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 28, 22, 0, 0), Category = "3D" },
                new Screening { Id = 107, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 28, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 108, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 28, 19, 0, 0), Category = "3D" },
                new Screening { Id = 109, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 29, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 110, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 29, 22, 0, 0), Category = "3D" },
                new Screening { Id = 111, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 29, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 112, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 29, 19, 0, 0), Category = "3D" },
                new Screening { Id = 113, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 30, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 114, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 30, 22, 0, 0), Category = "3D" },
                new Screening { Id = 115, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 30, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 116, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 30, 19, 0, 0), Category = "3D" },
                new Screening { Id = 117, HallId = 1, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 31, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 118, HallId = 2, MovieId = 2, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 31, 22, 0, 0), Category = "3D" },
                new Screening { Id = 119, HallId = 1, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 31, 18, 0, 0), Category = "4Dx" },
                new Screening { Id = 120, HallId = 2, MovieId = 4, Price = 15.00m, ScreeningTime = new DateTime(2024, 10, 31, 19, 0, 0), Category = "3D" },

                //Cinema2
                new Screening { Id = 121, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 2, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 122, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 3, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 123, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 4, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 124, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 5, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 125, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 6, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 126, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 7, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 127, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 8, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 128, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 9, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 129, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 10, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 130, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 11, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 131, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 12, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 132, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 13, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 133, HallId = 4, MovieId = 1, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 14, 20, 0, 0), Category = "4Dx" },
                new Screening { Id = 134, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 2, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 135, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 3, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 136, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 4, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 137, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 5, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 138, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 6, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 139, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 7, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 140, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 8, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 141, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 9, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 142, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 10, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 143, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 11, 22, 0, 0), Category = "4Dx" },
                new Screening { Id = 144, HallId = 4, MovieId = 3, Price = 12.50m, ScreeningTime = new DateTime(2024, 10, 12, 22, 0, 0), Category = "4Dx" }

            );

            modelBuilder.Entity<Seat>().HasData(
                //Hall1
                new Seat { Id = 1, HallId = 1, SeatNumber = 1, Category = "Single", Status = true },
                new Seat { Id = 2, HallId = 1, SeatNumber = 2, Category = "Disabled", Status = true },
                new Seat { Id = 3, HallId = 1, SeatNumber = 3, Category = "Disabled", Status = true },
                new Seat { Id = 4, HallId = 1, SeatNumber = 4, Category = "Disabled", Status = true },
                new Seat { Id = 5, HallId = 1, SeatNumber = 5, Category = "Single", Status = true },
                new Seat { Id = 6, HallId = 1, SeatNumber = 6, Category = "Disabled", Status = true },
                new Seat { Id = 7, HallId = 1, SeatNumber = 7, Category = "Single", Status = true },
                new Seat { Id = 8, HallId = 1, SeatNumber = 8, Category = "Disabled", Status = true },
                new Seat { Id = 9, HallId = 1, SeatNumber = 9, Category = "Single", Status = true },
                new Seat { Id = 10, HallId = 1, SeatNumber = 10, Category = "Single", Status = true },

                new Seat { Id = 11, HallId = 1, SeatNumber = 11, Category = "Single", Status = true },
                new Seat { Id = 12, HallId = 1, SeatNumber = 12, Category = "Single", Status = true },
                new Seat { Id = 13, HallId = 1, SeatNumber = 13, Category = "Single", Status = true },
                new Seat { Id = 14, HallId = 1, SeatNumber = 14, Category = "Single", Status = true },
                new Seat { Id = 15, HallId = 1, SeatNumber = 15, Category = "Single", Status = true },
                new Seat { Id = 16, HallId = 1, SeatNumber = 16, Category = "Single", Status = true },
                new Seat { Id = 17, HallId = 1, SeatNumber = 17, Category = "Single", Status = true },
                new Seat { Id = 18, HallId = 1, SeatNumber = 18, Category = "Single", Status = true },
                new Seat { Id = 19, HallId = 1, SeatNumber = 19, Category = "Single", Status = true },
                new Seat { Id = 20, HallId = 1, SeatNumber = 20, Category = "Single", Status = true },

                new Seat { Id = 21, HallId = 1, SeatNumber = 21, Category = "Single", Status = true },
                new Seat { Id = 22, HallId = 1, SeatNumber = 22, Category = "Single", Status = true },
                new Seat { Id = 23, HallId = 1, SeatNumber = 23, Category = "Single", Status = true },
                new Seat { Id = 24, HallId = 1, SeatNumber = 24, Category = "Single", Status = true },
                new Seat { Id = 25, HallId = 1, SeatNumber = 25, Category = "Single", Status = true },
                new Seat { Id = 26, HallId = 1, SeatNumber = 26, Category = "Double", Status = true },
                new Seat { Id = 27, HallId = 1, SeatNumber = 27, Category = "Single", Status = true },
                new Seat { Id = 28, HallId = 1, SeatNumber = 28, Category = "Single", Status = true },
                new Seat { Id = 29, HallId = 1, SeatNumber = 29, Category = "Single", Status = true },
                new Seat { Id = 30, HallId = 1, SeatNumber = 30, Category = "Single", Status = true },

                new Seat { Id = 31, HallId = 1, SeatNumber = 31, Category = "Single", Status = true },
                new Seat { Id = 32, HallId = 1, SeatNumber = 32, Category = "Single", Status = true },
                new Seat { Id = 33, HallId = 1, SeatNumber = 33, Category = "Single", Status = true },
                new Seat { Id = 34, HallId = 1, SeatNumber = 34, Category = "Single", Status = true },
                new Seat { Id = 35, HallId = 1, SeatNumber = 35, Category = "Single", Status = true },
                new Seat { Id = 36, HallId = 1, SeatNumber = 36, Category = "Single", Status = true },
                new Seat { Id = 37, HallId = 1, SeatNumber = 37, Category = "Single", Status = true },
                new Seat { Id = 38, HallId = 1, SeatNumber = 38, Category = "Double", Status = true },
                new Seat { Id = 39, HallId = 1, SeatNumber = 39, Category = "Single", Status = true },
                new Seat { Id = 40, HallId = 1, SeatNumber = 40, Category = "Single", Status = true },

                new Seat { Id = 41, HallId = 1, SeatNumber = 41, Category = "Single", Status = true },
                new Seat { Id = 42, HallId = 1, SeatNumber = 42, Category = "Single", Status = true },
                new Seat { Id = 43, HallId = 1, SeatNumber = 43, Category = "Single", Status = true },
                new Seat { Id = 44, HallId = 1, SeatNumber = 44, Category = "Single", Status = true },
                new Seat { Id = 45, HallId = 1, SeatNumber = 45, Category = "Double", Status = true },
                new Seat { Id = 46, HallId = 1, SeatNumber = 46, Category = "Single", Status = true },
                new Seat { Id = 47, HallId = 1, SeatNumber = 47, Category = "Single", Status = true },
                new Seat { Id = 48, HallId = 1, SeatNumber = 48, Category = "Single", Status = true },
                new Seat { Id = 49, HallId = 1, SeatNumber = 49, Category = "Single", Status = true },
                new Seat { Id = 50, HallId = 1, SeatNumber = 50, Category = "Single", Status = true },

                new Seat { Id = 51, HallId = 1, SeatNumber = 51, Category = "Double", Status = true },
                new Seat { Id = 52, HallId = 1, SeatNumber = 52, Category = "Single", Status = true },
                new Seat { Id = 53, HallId = 1, SeatNumber = 53, Category = "Single", Status = true },
                new Seat { Id = 54, HallId = 1, SeatNumber = 54, Category = "Double", Status = true },
                new Seat { Id = 55, HallId = 1, SeatNumber = 55, Category = "Single", Status = true },
                new Seat { Id = 56, HallId = 1, SeatNumber = 56, Category = "Single", Status = true },
                new Seat { Id = 57, HallId = 1, SeatNumber = 57, Category = "Single", Status = true },
                new Seat { Id = 58, HallId = 1, SeatNumber = 58, Category = "Single", Status = true },
                new Seat { Id = 59, HallId = 1, SeatNumber = 59, Category = "Single", Status = true },
                new Seat { Id = 60, HallId = 1, SeatNumber = 60, Category = "Single", Status = true },

                new Seat { Id = 61, HallId = 1, SeatNumber = 61, Category = "Double", Status = true },
                new Seat { Id = 62, HallId = 1, SeatNumber = 62, Category = "Single", Status = true },
                new Seat { Id = 63, HallId = 1, SeatNumber = 63, Category = "Double", Status = true },
                new Seat { Id = 64, HallId = 1, SeatNumber = 64, Category = "Single", Status = true },
                new Seat { Id = 65, HallId = 1, SeatNumber = 65, Category = "Double", Status = true },
                new Seat { Id = 66, HallId = 1, SeatNumber = 66, Category = "Single", Status = true },
                new Seat { Id = 67, HallId = 1, SeatNumber = 67, Category = "Single", Status = true },
                new Seat { Id = 68, HallId = 1, SeatNumber = 68, Category = "Single", Status = true },
                new Seat { Id = 69, HallId = 1, SeatNumber = 69, Category = "Double", Status = true },
                new Seat { Id = 70, HallId = 1, SeatNumber = 70, Category = "Single", Status = true },

                new Seat { Id = 71, HallId = 1, SeatNumber = 71, Category = "Single", Status = true },
                new Seat { Id = 72, HallId = 1, SeatNumber = 72, Category = "Single", Status = true },
                new Seat { Id = 73, HallId = 1, SeatNumber = 73, Category = "Single", Status = true },
                new Seat { Id = 74, HallId = 1, SeatNumber = 74, Category = "Single", Status = true },
                new Seat { Id = 75, HallId = 1, SeatNumber = 75, Category = "Double", Status = true },
                new Seat { Id = 76, HallId = 1, SeatNumber = 76, Category = "Single", Status = true },
                new Seat { Id = 77, HallId = 1, SeatNumber = 77, Category = "Single", Status = true },
                new Seat { Id = 78, HallId = 1, SeatNumber = 78, Category = "Single", Status = true },
                new Seat { Id = 79, HallId = 1, SeatNumber = 79, Category = "Single", Status = true },
                new Seat { Id = 80, HallId = 1, SeatNumber = 80, Category = "Single", Status = true },

                //Hall2
                new Seat { Id = 81, HallId = 2, SeatNumber = 1, Category = "Single", Status = true },
                new Seat { Id = 82, HallId = 2, SeatNumber = 2, Category = "Disabled", Status = true },
                new Seat { Id = 83, HallId = 2, SeatNumber = 3, Category = "Disabled", Status = true },
                new Seat { Id = 84, HallId = 2, SeatNumber = 4, Category = "Disabled", Status = true },
                new Seat { Id = 85, HallId = 2, SeatNumber = 5, Category = "Single", Status = true },
                new Seat { Id = 86, HallId = 2, SeatNumber = 6, Category = "Disabled", Status = true },
                new Seat { Id = 87, HallId = 2, SeatNumber = 7, Category = "Single", Status = true },
                new Seat { Id = 88, HallId = 2, SeatNumber = 8, Category = "Disabled", Status = true },
                new Seat { Id = 89, HallId = 2, SeatNumber = 9, Category = "Single", Status = true },
                new Seat { Id = 90, HallId = 2, SeatNumber = 10, Category = "Single", Status = true },

                new Seat { Id = 91, HallId = 2, SeatNumber = 11, Category = "Single", Status = true },
                new Seat { Id = 92, HallId = 2, SeatNumber = 12, Category = "Single", Status = true },
                new Seat { Id = 93, HallId = 2, SeatNumber = 13, Category = "Single", Status = true },
                new Seat { Id = 94, HallId = 2, SeatNumber = 14, Category = "Single", Status = true },
                new Seat { Id = 95, HallId = 2, SeatNumber = 15, Category = "Single", Status = true },
                new Seat { Id = 96, HallId = 2, SeatNumber = 16, Category = "Single", Status = true },
                new Seat { Id = 97, HallId = 2, SeatNumber = 17, Category = "Single", Status = true },
                new Seat { Id = 98, HallId = 2, SeatNumber = 18, Category = "Single", Status = true },
                new Seat { Id = 99, HallId = 2, SeatNumber = 19, Category = "Single", Status = true },
                new Seat { Id = 100, HallId = 2, SeatNumber = 20, Category = "Single", Status = true },

                new Seat { Id = 101, HallId = 2, SeatNumber = 21, Category = "Single", Status = true },
                new Seat { Id = 102, HallId = 2, SeatNumber = 22, Category = "Single", Status = true },
                new Seat { Id = 103, HallId = 2, SeatNumber = 23, Category = "Single", Status = true },
                new Seat { Id = 104, HallId = 2, SeatNumber = 24, Category = "Single", Status = true },
                new Seat { Id = 105, HallId = 2, SeatNumber = 25, Category = "Single", Status = true },
                new Seat { Id = 106, HallId = 2, SeatNumber = 26, Category = "Double", Status = true },
                new Seat { Id = 107, HallId = 2, SeatNumber = 27, Category = "Single", Status = true },
                new Seat { Id = 108, HallId = 2, SeatNumber = 28, Category = "Single", Status = true },
                new Seat { Id = 109, HallId = 2, SeatNumber = 29, Category = "Single", Status = true },
                new Seat { Id = 110, HallId = 2, SeatNumber = 30, Category = "Single", Status = true },

                new Seat { Id = 111, HallId = 2, SeatNumber = 31, Category = "Single", Status = true },
                new Seat { Id = 112, HallId = 2, SeatNumber = 32, Category = "Single", Status = true },
                new Seat { Id = 113, HallId = 2, SeatNumber = 33, Category = "Single", Status = true },
                new Seat { Id = 114, HallId = 2, SeatNumber = 34, Category = "Single", Status = true },
                new Seat { Id = 115, HallId = 2, SeatNumber = 35, Category = "Single", Status = true },
                new Seat { Id = 116, HallId = 2, SeatNumber = 36, Category = "Single", Status = true },
                new Seat { Id = 117, HallId = 2, SeatNumber = 37, Category = "Single", Status = true },
                new Seat { Id = 118, HallId = 2, SeatNumber = 38, Category = "Double", Status = true },
                new Seat { Id = 119, HallId = 2, SeatNumber = 39, Category = "Single", Status = true },
                new Seat { Id = 120, HallId = 2, SeatNumber = 40, Category = "Single", Status = true },

                new Seat { Id = 121, HallId = 2, SeatNumber = 41, Category = "Single", Status = true },
                new Seat { Id = 122, HallId = 2, SeatNumber = 42, Category = "Single", Status = true },
                new Seat { Id = 123, HallId = 2, SeatNumber = 43, Category = "Single", Status = true },
                new Seat { Id = 124, HallId = 2, SeatNumber = 44, Category = "Single", Status = true },
                new Seat { Id = 125, HallId = 2, SeatNumber = 45, Category = "Double", Status = true },
                new Seat { Id = 126, HallId = 2, SeatNumber = 46, Category = "Single", Status = true },
                new Seat { Id = 127, HallId = 2, SeatNumber = 47, Category = "Single", Status = true },
                new Seat { Id = 128, HallId = 2, SeatNumber = 48, Category = "Single", Status = true },
                new Seat { Id = 129, HallId = 2, SeatNumber = 49, Category = "Single", Status = true },
                new Seat { Id = 130, HallId = 2, SeatNumber = 50, Category = "Single", Status = true },

                new Seat { Id = 131, HallId = 2, SeatNumber = 51, Category = "Double", Status = true },
                new Seat { Id = 132, HallId = 2, SeatNumber = 52, Category = "Single", Status = true },
                new Seat { Id = 133, HallId = 2, SeatNumber = 53, Category = "Single", Status = true },
                new Seat { Id = 134, HallId = 2, SeatNumber = 54, Category = "Double", Status = true },
                new Seat { Id = 135, HallId = 2, SeatNumber = 55, Category = "Single", Status = true },
                new Seat { Id = 136, HallId = 2, SeatNumber = 56, Category = "Single", Status = true },
                new Seat { Id = 137, HallId = 2, SeatNumber = 57, Category = "Single", Status = true },
                new Seat { Id = 138, HallId = 2, SeatNumber = 58, Category = "Single", Status = true },
                new Seat { Id = 139, HallId = 2, SeatNumber = 59, Category = "Single", Status = true },
                new Seat { Id = 140, HallId = 2, SeatNumber = 60, Category = "Single", Status = true },

                new Seat { Id = 141, HallId = 2, SeatNumber = 61, Category = "Double", Status = true },
                new Seat { Id = 142, HallId = 2, SeatNumber = 62, Category = "Single", Status = true },
                new Seat { Id = 143, HallId = 2, SeatNumber = 63, Category = "Double", Status = true },
                new Seat { Id = 144, HallId = 2, SeatNumber = 64, Category = "Single", Status = true },
                new Seat { Id = 145, HallId = 2, SeatNumber = 65, Category = "Double", Status = true },
                new Seat { Id = 146, HallId = 2, SeatNumber = 66, Category = "Single", Status = true },
                new Seat { Id = 147, HallId = 2, SeatNumber = 67, Category = "Single", Status = true },
                new Seat { Id = 148, HallId = 2, SeatNumber = 68, Category = "Single", Status = true },
                new Seat { Id = 149, HallId = 2, SeatNumber = 69, Category = "Double", Status = true },
                new Seat { Id = 150, HallId = 2, SeatNumber = 70, Category = "Single", Status = true },

                new Seat { Id = 151, HallId = 2, SeatNumber = 71, Category = "Single", Status = true },
                new Seat { Id = 152, HallId = 2, SeatNumber = 72, Category = "Single", Status = true },
                new Seat { Id = 153, HallId = 2, SeatNumber = 73, Category = "Single", Status = true },
                new Seat { Id = 154, HallId = 2, SeatNumber = 74, Category = "Single", Status = true },
                new Seat { Id = 155, HallId = 2, SeatNumber = 75, Category = "Double", Status = true },
                new Seat { Id = 156, HallId = 2, SeatNumber = 76, Category = "Single", Status = true },
                new Seat { Id = 157, HallId = 2, SeatNumber = 77, Category = "Single", Status = true },
                new Seat { Id = 158, HallId = 2, SeatNumber = 78, Category = "Single", Status = true },
                new Seat { Id = 159, HallId = 2, SeatNumber = 79, Category = "Single", Status = true },
                new Seat { Id = 160, HallId = 2, SeatNumber = 80, Category = "Single", Status = true },

                //Hall4
                new Seat { Id = 161, HallId = 4, SeatNumber = 1, Category = "Single", Status = true },
                new Seat { Id = 162, HallId = 4, SeatNumber = 2, Category = "Disabled", Status = true },
                new Seat { Id = 163, HallId = 4, SeatNumber = 3, Category = "Disabled", Status = true },
                new Seat { Id = 164, HallId = 4, SeatNumber = 4, Category = "Disabled", Status = true },
                new Seat { Id = 165, HallId = 4, SeatNumber = 5, Category = "Single", Status = true },
                new Seat { Id = 166, HallId = 4, SeatNumber = 6, Category = "Disabled", Status = true },
                new Seat { Id = 167, HallId = 4, SeatNumber = 7, Category = "Single", Status = true },
                new Seat { Id = 168, HallId = 4, SeatNumber = 8, Category = "Disabled", Status = true },
                new Seat { Id = 169, HallId = 4, SeatNumber = 9, Category = "Single", Status = true },
                new Seat { Id = 170, HallId = 4, SeatNumber = 10, Category = "Single", Status = true },

                new Seat { Id = 171, HallId = 4, SeatNumber = 11, Category = "Single", Status = true },
                new Seat { Id = 172, HallId = 4, SeatNumber = 12, Category = "Single", Status = true },
                new Seat { Id = 173, HallId = 4, SeatNumber = 13, Category = "Single", Status = true },
                new Seat { Id = 174, HallId = 4, SeatNumber = 14, Category = "Single", Status = true },
                new Seat { Id = 175, HallId = 4, SeatNumber = 15, Category = "Single", Status = true },
                new Seat { Id = 176, HallId = 4, SeatNumber = 16, Category = "Single", Status = true },
                new Seat { Id = 177, HallId = 4, SeatNumber = 17, Category = "Single", Status = true },
                new Seat { Id = 178, HallId = 4, SeatNumber = 18, Category = "Single", Status = true },
                new Seat { Id = 179, HallId = 4, SeatNumber = 19, Category = "Single", Status = true },
                new Seat { Id = 180, HallId = 4, SeatNumber = 20, Category = "Single", Status = true },

                new Seat { Id = 181, HallId = 4, SeatNumber = 21, Category = "Single", Status = true },
                new Seat { Id = 182, HallId = 4, SeatNumber = 22, Category = "Single", Status = true },
                new Seat { Id = 183, HallId = 4, SeatNumber = 23, Category = "Single", Status = true },
                new Seat { Id = 184, HallId = 4, SeatNumber = 24, Category = "Single", Status = true },
                new Seat { Id = 185, HallId = 4, SeatNumber = 25, Category = "Single", Status = true },
                new Seat { Id = 186, HallId = 4, SeatNumber = 26, Category = "Double", Status = true },
                new Seat { Id = 187, HallId = 4, SeatNumber = 27, Category = "Single", Status = true },
                new Seat { Id = 188, HallId = 4, SeatNumber = 28, Category = "Single", Status = true },
                new Seat { Id = 189, HallId = 4, SeatNumber = 29, Category = "Single", Status = true },
                new Seat { Id = 190, HallId = 4, SeatNumber = 30, Category = "Single", Status = true },

                new Seat { Id = 191, HallId = 4, SeatNumber = 31, Category = "Single", Status = true },
                new Seat { Id = 192, HallId = 4, SeatNumber = 32, Category = "Single", Status = true },
                new Seat { Id = 193, HallId = 4, SeatNumber = 33, Category = "Single", Status = true },
                new Seat { Id = 194, HallId = 4, SeatNumber = 34, Category = "Single", Status = true },
                new Seat { Id = 195, HallId = 4, SeatNumber = 35, Category = "Single", Status = true },
                new Seat { Id = 196, HallId = 4, SeatNumber = 36, Category = "Single", Status = true },
                new Seat { Id = 197, HallId = 4, SeatNumber = 37, Category = "Single", Status = true },
                new Seat { Id = 198, HallId = 4, SeatNumber = 38, Category = "Double", Status = true },
                new Seat { Id = 199, HallId = 4, SeatNumber = 39, Category = "Single", Status = true },
                new Seat { Id = 200, HallId = 4, SeatNumber = 40, Category = "Single", Status = true },

                new Seat { Id = 201, HallId = 4, SeatNumber = 41, Category = "Single", Status = true },
                new Seat { Id = 202, HallId = 4, SeatNumber = 42, Category = "Single", Status = true },
                new Seat { Id = 203, HallId = 4, SeatNumber = 43, Category = "Single", Status = true },
                new Seat { Id = 204, HallId = 4, SeatNumber = 44, Category = "Single", Status = true },
                new Seat { Id = 205, HallId = 4, SeatNumber = 45, Category = "Double", Status = true },
                new Seat { Id = 206, HallId = 4, SeatNumber = 46, Category = "Single", Status = true },
                new Seat { Id = 207, HallId = 4, SeatNumber = 47, Category = "Single", Status = true },
                new Seat { Id = 208, HallId = 4, SeatNumber = 48, Category = "Single", Status = true },
                new Seat { Id = 209, HallId = 4, SeatNumber = 49, Category = "Single", Status = true },
                new Seat { Id = 210, HallId = 4, SeatNumber = 50, Category = "Single", Status = true },

                new Seat { Id = 211, HallId = 4, SeatNumber = 51, Category = "Double", Status = true },
                new Seat { Id = 212, HallId = 4, SeatNumber = 52, Category = "Single", Status = true },
                new Seat { Id = 213, HallId = 4, SeatNumber = 53, Category = "Single", Status = true },
                new Seat { Id = 214, HallId = 4, SeatNumber = 54, Category = "Double", Status = true },
                new Seat { Id = 215, HallId = 4, SeatNumber = 55, Category = "Single", Status = true },
                new Seat { Id = 216, HallId = 4, SeatNumber = 56, Category = "Single", Status = true },
                new Seat { Id = 217, HallId = 4, SeatNumber = 57, Category = "Single", Status = true },
                new Seat { Id = 218, HallId = 4, SeatNumber = 58, Category = "Single", Status = true },
                new Seat { Id = 219, HallId = 4, SeatNumber = 59, Category = "Single", Status = true },
                new Seat { Id = 220, HallId = 4, SeatNumber = 60, Category = "Single", Status = true },

                new Seat { Id = 221, HallId = 4, SeatNumber = 61, Category = "Double", Status = true },
                new Seat { Id = 222, HallId = 4, SeatNumber = 62, Category = "Single", Status = true },
                new Seat { Id = 223, HallId = 4, SeatNumber = 63, Category = "Double", Status = true },
                new Seat { Id = 224, HallId = 4, SeatNumber = 64, Category = "Single", Status = true },
                new Seat { Id = 225, HallId = 4, SeatNumber = 65, Category = "Double", Status = true },
                new Seat { Id = 226, HallId = 4, SeatNumber = 66, Category = "Single", Status = true },
                new Seat { Id = 227, HallId = 4, SeatNumber = 67, Category = "Single", Status = true },
                new Seat { Id = 228, HallId = 4, SeatNumber = 68, Category = "Single", Status = true },
                new Seat { Id = 229, HallId = 4, SeatNumber = 69, Category = "Double", Status = true },
                new Seat { Id = 230, HallId = 4, SeatNumber = 70, Category = "Single", Status = true },

                new Seat { Id = 231, HallId = 4, SeatNumber = 71, Category = "Single", Status = true },
                new Seat { Id = 232, HallId = 4, SeatNumber = 72, Category = "Single", Status = true },
                new Seat { Id = 233, HallId = 4, SeatNumber = 73, Category = "Single", Status = true },
                new Seat { Id = 234, HallId = 4, SeatNumber = 74, Category = "Single", Status = true },
                new Seat { Id = 235, HallId = 4, SeatNumber = 75, Category = "Double", Status = true },
                new Seat { Id = 236, HallId = 4, SeatNumber = 76, Category = "Single", Status = true },
                new Seat { Id = 237, HallId = 4, SeatNumber = 77, Category = "Single", Status = true },
                new Seat { Id = 238, HallId = 4, SeatNumber = 78, Category = "Single", Status = true },
                new Seat { Id = 239, HallId = 4, SeatNumber = 79, Category = "Single", Status = true },
                new Seat { Id = 240, HallId = 4, SeatNumber = 80, Category = "Single", Status = true }

            );

            modelBuilder.Entity<Promotion>().HasData(
                new Promotion { Id = 1, Code = "Code0", Discount = 0.00m, ExpirationDate = new DateTime(2035, 8, 27) },
                new Promotion { Id = 2, Code = "Summer20", Discount = 20.00m, ExpirationDate = new DateTime(2024, 8, 27) },
                new Promotion { Id = 3, Code = "Summer25", Discount = 25.00m, ExpirationDate = new DateTime(2024, 9, 27) }
            );

            modelBuilder.Entity<Booking>().HasData(
                new Booking { Id = 1, UserId = 1, ScreeningId = 1, Price = 25.00m, PromotionId = 1 },
                new Booking { Id = 2, UserId = 1, ScreeningId = 2, Price = 30.00m, PromotionId = 2 },
                new Booking { Id = 3, UserId = 2, ScreeningId = 1, Price = 25.00m, PromotionId = 1 }
            );

            modelBuilder.Entity<BookingSeat>().HasData(
                new BookingSeat { BookingSeatId = 1, BookingId = 1, SeatId = 1 },
                new BookingSeat { BookingSeatId = 2, BookingId = 1, SeatId = 2 },
                new BookingSeat { BookingSeatId = 3, BookingId = 2, SeatId = 84 },
                new BookingSeat { BookingSeatId = 4, BookingId = 2, SeatId = 85 },
                new BookingSeat { BookingSeatId = 5, BookingId = 3, SeatId = 10 },
                new BookingSeat { BookingSeatId = 6, BookingId = 3, SeatId = 11 }

            );

            modelBuilder.Entity<Ticket>().HasData(
                new Ticket { Id = 1, BookingSeatId = 1, Price = 12.50m, TicketCode = "E3DBB11CE45E", QrCode = "iVBORw0KGgoAAAANSUhEUgAAASwAAAEsCAYAAAB5fY51AAAABHNCSVQICAgIfAhkiAAACQpJREFUeJzt3UFuG7kWhtHrh+zLzMpCrczUyvIGdoCeNDq5VFj+5XMAoUcXrFIpX6MGpF+qanx8+Bxm0Jrdua5Rvd/q+vh0zOYcj7eq3h/IT59P8zltNK/z7YJrnc1rnRtrXv178PnHc/zffzwsgE9DsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwgxreN2VVV9wddxzP6cXi9sTF7a8ysjfVGc667ZnduR+c7/Spea+P3Ouv8DvivoLsjvWs215sba3a9Na91XHCtp5/jVzDLaQ3AsxMsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ixc1pD16hrNrF2zasv4Detet8Fn8ApH/9uXn0Bf2DV4ZMwrgrW6aNXdsyrL+A3rer9eEb1ThdYVfW9MVeV851eIenfRtXhYHklBGIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwgxhWnNfB3zOodL3OrqpfHXsp/mtW/1vXQKyGKYD2X0Zi51/kIvFbvWm8Pvg7CeCUEYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcSw+fl5zDq/iXk25+7NuVG9TdOrnPLwFATruazD6/1ozq3qhac25lZzjk/EKyEQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIbNz89jNOfW5mzHvfonNnSsg2vxF10RrFn9Y0n4d6N6pyes6h/Z0pmrqvrenJvNNe+VE62Xqy/gM/NKCMQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuI4bSG57Gq6nVj9k+dPG3hl1X9e+QJ7ATrR/VOB+DvGNU7yeBW/dMzfjbnukb1T2s47fR38yV4JQRiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIMbL1RdAtLfm3L3OHhNzq94ROsAT+dn8vB2em3/p/jnMKyEQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIMZLVY2Pz59azbkdp9dc1d/lPzfWHM3Z0+uth13F7/vRmLlvrDebc6P6/65Wc815eG7U+XusWRk77tN2+afc487caXPjWk/fY3fN0VxvNNdLukevhEAOwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGN8+/rsas90d8Ds75+/N+bUx13Vrzr02173V2Wey6ppTHjqzO7+bHZ35nTU7v7lVe6eDrOZcZ81VlXVaw1dwfAf8htPPcTbXmxtrdn2F53i6AdMrIRBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwgxrd63wH92pxfjZmd0xq+gqTvZ12wXve3etpXeI5XnNjSNqq/U/u0uXGtJ+euWHNnrqu75miuN5rr7TzH00bzOnee43FeCYEYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiPFtY3ZV1UtztrtD/Htzbn58/tRornev/rWeNppz9zr/HHesxkzSc6zq32P3Od6rd9zPrZpH2uwEa8e4aN2OcfUFHDAOz11hXH0BB4zDc93ZW3cxr4RADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBi7m59nc24150b1Nluu5prduar+d9OdG3X2u6nqn2Qw6vxzPH3qwqjnv8f74fW2jKr62fi8Ned2ZkfQPXbNw9faPZKkNtYcG2uelnSPKf8evRICOQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmLsntbQ+ZPTq/Z2eXdm18Z6V9xj12rM3Kv/nY7G3M6a1VxzNed+zXa4x8evxxOZ1ds5PzfWdCLF482Naz05t/Mc27wSAjEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJi7J7WwOexqur1gjVPr9e9x9WYuerEjWe/xy2z+ru1fR7/6ZrN9ebGmqfN6t3j28ZcV3fNsbFmV/e3evwevRICMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhDjpd53wP9ozN4qa6f/ad2TF14eehX/bVTv+d+r//xnnT0K51bnj8I5bVT/OXafxffmXJvzsKg6f6TJa3PN1Zy71/MHq6r/HLtzx3klBGIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEuGLz86zervKrnD49oWtUf0PxeuB1/I774bmq8yeLrDr7PFadPz1h1NmN08tpDc9jVO9/BDsnJ3R116zDc2tjvSu+1+7s28aaozGzmnNeCYEcggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMWx+fi6rMXPFyQn3zfnOet253fvsGI2Z1VxrZ7b7/azunGA9l3F4rmtuzI3mbHfu9JEts3qnbtyq/72O5tzOd7M6Q14JgRiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExbH5+Hqve/zx6d/ZPnTxt4ZdV7vFvrRlBsJ7HqP6xJJ25HW/NNVdzbuckg67uPX6v8ydEnF6vzSshEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExrjitYV2w5lexGjPdI1Tu9X4iQXe2ax2a2dW9xx8fn856nWNpunNVF5zycFWw1gXrfgUjZK47u5pz9zr/m3ut88f9nJ47zishEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCDGzubn16qaD7oO9q3q79bv6u7WH825nWudG7Md3Wu9fXy6syeN6m/wXt1FZ1X99Pk0n67ZXO9tY65rZ82EuZ3Z0f9a22Lu0SshEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCDGt/Jn45/F2pjtnCywu153ze4pCKfX21nztJ1THo7e4/8B5V3af+9gHn8AAAAASUVORK5CYII=", UserId = 1 },
                new Ticket { Id = 2, BookingSeatId = 2, Price = 12.50m, TicketCode = "233DADBBE44F", QrCode = "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", UserId = 1 },
                new Ticket { Id = 3, BookingSeatId = 3, Price = 15.00m, TicketCode = "E3BA0200440C", QrCode = "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", UserId = 1 },
                new Ticket { Id = 4, BookingSeatId = 4, Price = 15.00m, TicketCode = "03DD405DBBAE", QrCode = "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", UserId = 1 },

                new Ticket { Id = 5, BookingSeatId = 5, Price = 12.50m, TicketCode = "B2A4E400EECE", QrCode = "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", UserId = 2 },
                new Ticket { Id = 6, BookingSeatId = 6, Price = 12.50m, TicketCode = "4FA54FAA103C", QrCode = "iVBORw0KGgoAAAANSUhEUgAAASwAAAEsCAYAAAB5fY51AAAABHNCSVQICAgIfAhkiAAACLZJREFUeJzt3UFyI7sRRdFsR+9L+CsTuDKBK5MH0rc9sd1KSCg96pwIDjOyihRvBweF/lVV4/3F9zCbc6N6n+N6fyUYdf4eZ3OOz7d+19sfwPPFF8K/zebcqP7nuJpzp406f4++G9/IP66+AIA/JVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEOP3xuyqqvsnXccjuuKh2dWcGQf31QX7unM7bhfsTPFUGyfEzKp6bbxm/3p/hM57+rqxbzb3vWzMdXV3jo2dXac/x59gVrM5fhICMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmLsnNbQNeqah1i75tUX8IdWvT0F3539qJ2TOpzy8d/Nqy/gA1YdPgnjqmBdcfRK17z6Av7QqN4/BKs5V9U/lWBnZ+eUiFvlfI5J342qw8HykxCIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBhXnNbA11mNmVtV/dXc1zk5oTb2zebcas7xzQjWYxmNmXv1v9Cdfbs6O3fukW/ET0IghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAwPPz+OWf0HfGdzrrtvVP/B6e5OHoBgPZbVmBlV9dzcNRpz/7n31M57Y4ZvyE9CIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMDz8/jrExe2vMrI199zr7QPI6uIsvNqvqtfGa5y81Suc9fd3YN5v75sZO9/j59/gTzGp+jn4SAjEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiOK3hcayqerpg5+l9p++Rb2QnWM/vL76HUb0jZnaOeens2zGaO08eZfM3JzZ8AT8JgRiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAsAAAAAAAAAAAAAAAAAAAAA4CH9qqrx/vqo1ZyrqprNua5R5++xax7el2RU/3Ncn3gdf2LU+WudzbmuVWe/H6vq7SZfG6+XjbnT5sa1npx7/aL7fxSzeu/pPH+p7b+B0dw3mvt2/lZPfz+mA/yAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATF+1/mn2O91/gSEqt593pu77huzozm3mnM7O7vW4dlV5++x+zewNnZ2Zrt/p1fs7Oz6l1GP/3T4zlxXd+do7hvNfTufY9c8fK1X3GPXaF7nzj2efl+d1gDkECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiPF7c341ZnaeDt85PaFrHd63+/R8x2rMXHWdTxuzH3XFPe5YjZm07+MlTj8dPprXOQ5f5095yr9rHr7Wl41r7Zob13r6c+zOju6b4ychEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExfl19AXyaWb2jV+6H53ZnO27VO3rlCrN6703SPbbtnofF9zJC5rqzqzl3r6wv82jMpN1ji5+EQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYu6c1zM+4iA9Y1X9odjV3zuZcV3ffqKrnxtwVD82O6p9I0LU2Zk8bzbnVnJuH50b1v8dto6peG6+X5tzO7Ai6x67Z3Dc3dnad/hz532L+Vv0kBGIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXE2P2v6jtPz696OyGgqzO7NvZdcY9d69DM30Zz7l7996ezczXndqzD+3askH3dOb6hWedPa0h5yr97OsQVp25cIeYe/SQEYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcTYPa2B72NV1dMFO0/v697jasxcceLGFdbVF/ARs/pPa3t9/uu00bzOl+bczuy44B5Pm81rnecv9Tw/CYEYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiLFzvMytfsgT4k2nT16Y1Tt65VZVvz73Ur7MrKrnxtwV9zir/3nMxtyo3ukS9+a+SzgP67GMxsy9ss5DGo2ZK+7xqXrXetvY2dkXxU9CIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWECMKx5+ntV74v4qKScZrOqdDrBjHp5bdf4eu+6H963Keoi9xWkNj2NU/ySDru4/PLM5N+r8PXadPq1hNPet5r5L+EkIxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4jh4efHsQ7PVe39t+pdqzkzPvUq/r979R66Xhs7O7P3yvkv7pdgPY5V55+8n4f3VfW/XJ25tbHvimOJRnOue+rGau7szt38JARiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxPDwM0lWvf0X8N3Zj7riv7jfsRozO/fYnW3vFCxGVb005lZV/fWpV/JnO9fhnafN6p2ecKvzn8dxfhICMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhDjitMa1gU7f4JZvaNX7pVz9Mqs3j3e6vzf3ayzR+FU9U7duNfbtUa4Kljrgr0/wTg8d4XRmOlGecdT9a51NedqYy6Gn4RADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBg7Dz8/VdBT3j/Aqv5pDSlW9U9AOK37vt7eX49sVPPB8J1gdZfyNUadfcp/NXftGNU/reG07mkN3aNwRnNfZ9euUVXPnUE/CYEYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMX6X/zb+UayN2c7DwTv7uro7u3M77nX+fe2c8rCzr6u7c/0Thy81DkniETQAAAAASUVORK5CYII=", UserId = 2 }
            );

            modelBuilder.Entity<Review>().HasData(
                new Review { Id = 1, MovieId = 1, UserId = 1, Rating = 5, Comment = "Amazing movie!" },
                new Review { Id = 2, MovieId = 2, UserId = 1, Rating = 4, Comment = "Very touching film." },
                new Review { Id = 3, MovieId = 1, UserId = 2, Rating = 3, Comment = "Good." },
                new Review { Id = 4, MovieId = 2, UserId = 2, Rating = 2, Comment = "Bad." }
            );

            modelBuilder.Entity<Payment>().HasData(
                new Payment { Id = 1, BookingId = 1, Amount = 25.00m, PaymentStatus = "successfully" },
                new Payment { Id = 2, BookingId = 2, Amount = 30.00m, PaymentStatus = "successfully" },
                new Payment { Id = 3, BookingId = 3, Amount = 25.00m, PaymentStatus = "successfully" }
            );

            modelBuilder.Entity<News>().HasData(
                new News { Id = 1, CinemaId = 1, Name = "Public holiday", Description = "25.11.2024. Cinebox Zagreb will not work, See you soon :)", CreatedDate = DateTime.Now },
                new News { Id = 2, CinemaId = 1, Name = "New working time", Description = "From 01.07.2024. CineBox will have a new working time 18:00 - 02:00", CreatedDate = DateTime.Now },
                new News { Id = 3, CinemaId = 2, Name = "New working time", Description = "From 01.07.2024. CineBox will have a new working time 18:00 - 02:00", CreatedDate = DateTime.Now }
            );
        }
    }
}

