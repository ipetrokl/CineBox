using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CineBox.Services.Migrations
{
    /// <inheritdoc />
    public partial class CineBoxInitializerV1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Actor",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { 1, "Leonardo DiCaprio" },
                    { 2, "Kate Winslet" }
                });

            migrationBuilder.InsertData(
                table: "Cinema",
                columns: new[] { "id", "location", "name" },
                values: new object[,]
                {
                    { 1, "New York", "Cineworld" },
                    { 2, "Los Angeles", "IMAX" }
                });

            migrationBuilder.InsertData(
                table: "Genre",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { 1, "Drama" },
                    { 2, "Action" }
                });

            migrationBuilder.InsertData(
                table: "Promotion",
                columns: new[] { "id", "code", "discount", "expiration_date" },
                values: new object[] { 1, "SUMMER20", 20.00m, new DateTime(2024, 8, 31, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.InsertData(
                table: "User",
                columns: new[] { "id", "email", "name", "passwordHash", "passwordSalt", "phone", "status", "surname", "username" },
                values: new object[,]
                {
                    { 1, "john@example.com", "John", "hash1", "salt1", "123-456-7890", true, "Doe", "john_doe" },
                    { 2, "jane@example.com", "Jane", "hash2", "salt2", "987-654-3210", true, "Smith", "jane_smith" }
                });

            migrationBuilder.InsertData(
                table: "Hall",
                columns: new[] { "id", "cinema_id", "name" },
                values: new object[,]
                {
                    { 1, 1, "Hall 1" },
                    { 2, 2, "Hall 2" }
                });

            migrationBuilder.InsertData(
                table: "Movie",
                columns: new[] { "id", "description", "director", "genre_id", "performed_from", "performed_to", "picture", "pictureThumb", "stateMachine", "title" },
                values: new object[,]
                {
                    { 1, "A mind-bending thriller", "Christopher Nolan", 1, new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified), null, null, null, "Inception" },
                    { 2, "A romantic disaster film", "James Cameron", 1, new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified), null, null, null, "Titanic" }
                });

            migrationBuilder.InsertData(
                table: "UsersRoles",
                columns: new[] { "UsersRolesId", "dateOfModification", "role_id", "user_id" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 23, 15, 29, 49, 84, DateTimeKind.Local).AddTicks(7140), 1, 1 },
                    { 2, new DateTime(2024, 7, 23, 15, 29, 49, 84, DateTimeKind.Local).AddTicks(7200), 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Review",
                columns: new[] { "id", "comment", "movie_id", "rating", "user_id" },
                values: new object[,]
                {
                    { 1, "Amazing movie!", 1, 5, 1 },
                    { 2, "Very touching film.", 2, 4, 2 }
                });

            migrationBuilder.InsertData(
                table: "Screening",
                columns: new[] { "id", "category", "hall_id", "movie_id", "price", "screening_time" },
                values: new object[,]
                {
                    { 1, "Standard", 1, 1, 12.50m, new DateTime(2024, 7, 24, 20, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, "Premium", 2, 2, 15.00m, new DateTime(2024, 7, 24, 22, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Seat",
                columns: new[] { "id", "category", "hall_id", "seat_number", "status" },
                values: new object[,]
                {
                    { 1, "Standard", 1, 1, true },
                    { 2, "Standard", 1, 2, true },
                    { 3, "Premium", 2, 1, true },
                    { 4, "Premium", 2, 2, true }
                });

            migrationBuilder.InsertData(
                table: "Booking",
                columns: new[] { "id", "price", "promotion_Id", "screening_id", "user_id" },
                values: new object[,]
                {
                    { 1, 25.00m, 1, 1, 1 },
                    { 2, 30.00m, 1, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "BookingSeat",
                columns: new[] { "bookingSeatId", "booking_id", "seat_id" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 1, 2 },
                    { 3, 2, 3 },
                    { 4, 2, 4 }
                });

            migrationBuilder.InsertData(
                table: "Payment",
                columns: new[] { "id", "amount", "booking_id", "payment_status" },
                values: new object[,]
                {
                    { 1, 25.00m, 1, "Completed" },
                    { 2, 30.00m, 2, "Completed" }
                });

            migrationBuilder.InsertData(
                table: "Ticket",
                columns: new[] { "id", "booking_seat_id", "price", "qr_code", "ticket_code", "user_id" },
                values: new object[,]
                {
                    { 1, 1, 12.50m, "QR001", "TICKET001", 1 },
                    { 2, 2, 12.50m, "QR002", "TICKET002", 1 },
                    { 3, 3, 15.00m, "QR003", "TICKET003", 2 },
                    { 4, 4, 15.00m, "QR004", "TICKET004", 2 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Actor",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Actor",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Payment",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Payment",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Review",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Review",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ticket",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Ticket",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ticket",
                keyColumn: "id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ticket",
                keyColumn: "id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "UsersRoles",
                keyColumn: "UsersRolesId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "UsersRoles",
                keyColumn: "UsersRolesId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "BookingSeat",
                keyColumn: "bookingSeatId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "BookingSeat",
                keyColumn: "bookingSeatId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "BookingSeat",
                keyColumn: "bookingSeatId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "BookingSeat",
                keyColumn: "bookingSeatId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Booking",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Booking",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Seat",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Seat",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Seat",
                keyColumn: "id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Seat",
                keyColumn: "id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Promotion",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Screening",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Screening",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Hall",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Hall",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Movie",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Movie",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Cinema",
                keyColumn: "id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Cinema",
                keyColumn: "id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "id",
                keyValue: 1);
        }
    }
}
