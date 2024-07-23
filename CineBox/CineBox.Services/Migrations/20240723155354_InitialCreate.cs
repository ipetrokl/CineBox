using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CineBox.Services.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Actor",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Actor__3213E83F2E81C85E", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Cinema",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    location = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Cinema__3213E83F23CFAD71", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Genre",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Genre__3213E83F38AFBD04", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Promotion",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    code = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    discount = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    expiration_date = table.Column<DateTime>(type: "date", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Promotio__3213E83FC04BB357", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Roles__3213E83F76DBADCD", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    surname = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    email = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    phone = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    username = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    passwordHash = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    passwordSalt = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__User__3213E83F430A5CF0", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Hall",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    cinema_id = table.Column<int>(type: "int", nullable: false),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Hall__3213E83FD9AF1396", x => x.id);
                    table.ForeignKey(
                        name: "FK__Hall__cinema_id__45F365D3",
                        column: x => x.cinema_id,
                        principalTable: "Cinema",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "News",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    cinema_id = table.Column<int>(type: "int", nullable: false),
                    name = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    description = table.Column<string>(type: "varchar(max)", unicode: false, nullable: false),
                    created_date = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__News__3213E83F8B80E9AE", x => x.id);
                    table.ForeignKey(
                        name: "FK__News__cinema_id__02FC7413",
                        column: x => x.cinema_id,
                        principalTable: "Cinema",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Movie",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    genre_id = table.Column<int>(type: "int", nullable: false),
                    title = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    description = table.Column<string>(type: "varchar(max)", unicode: false, nullable: false),
                    performed_from = table.Column<DateTime>(type: "date", nullable: false),
                    performed_to = table.Column<DateTime>(type: "date", nullable: false),
                    director = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    picture = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    pictureThumb = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    stateMachine = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Movie__3213E83F2BD5909A", x => x.id);
                    table.ForeignKey(
                        name: "FK__Movie__genre_id__412EB0B6",
                        column: x => x.genre_id,
                        principalTable: "Genre",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "UsersRoles",
                columns: table => new
                {
                    UsersRolesId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<int>(type: "int", nullable: false),
                    role_id = table.Column<int>(type: "int", nullable: false),
                    dateOfModification = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__UsersRol__A9752347C3F9B8FD", x => x.UsersRolesId);
                    table.ForeignKey(
                        name: "FK__UsersRole__role___3E52440B",
                        column: x => x.role_id,
                        principalTable: "Roles",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__UsersRole__user___3D5E1FD2",
                        column: x => x.user_id,
                        principalTable: "User",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Seat",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    hall_id = table.Column<int>(type: "int", nullable: false),
                    seat_number = table.Column<int>(type: "int", nullable: false),
                    category = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    status = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Seat__3213E83F0DCCBA47", x => x.id);
                    table.ForeignKey(
                        name: "FK__Seat__status__5FB337D6",
                        column: x => x.hall_id,
                        principalTable: "Hall",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "MovieActor",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    movie_id = table.Column<int>(type: "int", nullable: false),
                    actor_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__MovieAct__3213E83F842B29CF", x => x.id);
                    table.ForeignKey(
                        name: "FK__MovieActo__actor__5CD6CB2B",
                        column: x => x.actor_id,
                        principalTable: "Actor",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__MovieActo__movie__5BE2A6F2",
                        column: x => x.movie_id,
                        principalTable: "Movie",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Review",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<int>(type: "int", nullable: false),
                    movie_id = table.Column<int>(type: "int", nullable: false),
                    rating = table.Column<int>(type: "int", nullable: false),
                    comment = table.Column<string>(type: "varchar(max)", unicode: false, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Review__3213E83FD26CF094", x => x.id);
                    table.ForeignKey(
                        name: "FK__Review__movie_id__571DF1D5",
                        column: x => x.movie_id,
                        principalTable: "Movie",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__Review__user_id__5629CD9C",
                        column: x => x.user_id,
                        principalTable: "User",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Screening",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    movie_id = table.Column<int>(type: "int", nullable: false),
                    hall_id = table.Column<int>(type: "int", nullable: false),
                    category = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    screening_time = table.Column<DateTime>(type: "datetime", nullable: false),
                    price = table.Column<decimal>(type: "decimal(10,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Screenin__3213E83F341DB2BE", x => x.id);
                    table.ForeignKey(
                        name: "FK__Screening__hall___49C3F6B7",
                        column: x => x.hall_id,
                        principalTable: "Hall",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__Screening__movie__48CFD27E",
                        column: x => x.movie_id,
                        principalTable: "Movie",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Booking",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<int>(type: "int", nullable: false),
                    screening_id = table.Column<int>(type: "int", nullable: false),
                    price = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    promotion_Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Booking__3213E83F4DE83FAA", x => x.id);
                    table.ForeignKey(
                        name: "FK_Booking_Promotion",
                        column: x => x.promotion_Id,
                        principalTable: "Promotion",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__Booking__screeni__4D94879B",
                        column: x => x.screening_id,
                        principalTable: "Screening",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__Booking__user_id__4CA06362",
                        column: x => x.user_id,
                        principalTable: "User",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "BookingSeat",
                columns: table => new
                {
                    bookingSeatId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    booking_id = table.Column<int>(type: "int", nullable: false),
                    seat_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__BookingS__0F3B47D633C275B0", x => x.bookingSeatId);
                    table.ForeignKey(
                        name: "FK__BookingSe__booki__6477ECF3",
                        column: x => x.booking_id,
                        principalTable: "Booking",
                        principalColumn: "id");
                    table.ForeignKey(
                        name: "FK__BookingSe__seat___656C112C",
                        column: x => x.seat_id,
                        principalTable: "Seat",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Payment",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    booking_id = table.Column<int>(type: "int", nullable: false),
                    amount = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    payment_status = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Payment__3213E83F05BAE6AD", x => x.id);
                    table.ForeignKey(
                        name: "FK__Payment__booking__534D60F1",
                        column: x => x.booking_id,
                        principalTable: "Booking",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "Ticket",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ticket_code = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    qr_code = table.Column<string>(type: "varchar(max)", unicode: false, nullable: false),
                    price = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    user_id = table.Column<int>(type: "int", nullable: false),
                    booking_seat_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Ticket__3213E83FBF00AE8F", x => x.id);
                    table.ForeignKey(
                        name: "FK_Ticket_BookingSeat",
                        column: x => x.booking_seat_id,
                        principalTable: "BookingSeat",
                        principalColumn: "bookingSeatId");
                    table.ForeignKey(
                        name: "FK_Ticket_User",
                        column: x => x.user_id,
                        principalTable: "User",
                        principalColumn: "id");
                });

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
                values: new object[,]
                {
                    { 1, "Code0", 0.00m, new DateTime(2035, 8, 27, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, "Summer20", 20.00m, new DateTime(2024, 8, 27, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, "Summer25", 25.00m, new DateTime(2024, 9, 27, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Roles",
                columns: new[] { "id", "description", "name" },
                values: new object[,]
                {
                    { 1, "admin", "admin" },
                    { 2, "guest", "guest" }
                });

            migrationBuilder.InsertData(
                table: "User",
                columns: new[] { "id", "email", "name", "passwordHash", "passwordSalt", "phone", "status", "surname", "username" },
                values: new object[,]
                {
                    { 1, "john@example.com", "John", "6YN5P1X5LBm8BrXPRbgxo9gOhRc=", "AE9YsGCoSj4H1vy1RUHkng==", "123-456-7890", true, "Doe", "test" },
                    { 2, "jane@example.com", "Jane", "hash2", "salt2", "987-654-3210", true, "Smith", "jane_smith" }
                });

            migrationBuilder.InsertData(
                table: "Hall",
                columns: new[] { "id", "cinema_id", "name" },
                values: new object[,]
                {
                    { 1, 1, "Hall 1" },
                    { 2, 1, "Hall 2" },
                    { 3, 1, "Hall 3" },
                    { 4, 2, "Hall 1" },
                    { 5, 2, "Hall 2" },
                    { 6, 2, "Hall 3" }
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
                table: "News",
                columns: new[] { "id", "cinema_id", "created_date", "description", "name" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2024, 7, 23, 17, 53, 54, 592, DateTimeKind.Local).AddTicks(1420), "25.11.2024. Cinebox Zagreb will not work, See you soon :)", "Public holiday" },
                    { 2, 1, new DateTime(2024, 7, 23, 17, 53, 54, 592, DateTimeKind.Local).AddTicks(1420), "From 01.07.2024. CineBox will have a new working time 18:00 - 02:00", "New working time" },
                    { 3, 2, new DateTime(2024, 7, 23, 17, 53, 54, 592, DateTimeKind.Local).AddTicks(1430), "From 01.07.2024. CineBox will have a new working time 18:00 - 02:00", "New working time" }
                });

            migrationBuilder.InsertData(
                table: "UsersRoles",
                columns: new[] { "UsersRolesId", "dateOfModification", "role_id", "user_id" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 23, 17, 53, 54, 592, DateTimeKind.Local).AddTicks(980), 1, 1 },
                    { 2, new DateTime(2024, 7, 23, 17, 53, 54, 592, DateTimeKind.Local).AddTicks(1030), 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "MovieActor",
                columns: new[] { "id", "actor_id", "movie_id" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Review",
                columns: new[] { "id", "comment", "movie_id", "rating", "user_id" },
                values: new object[,]
                {
                    { 1, "Amazing movie!", 1, 5, 1 },
                    { 2, "Very touching film.", 2, 4, 1 },
                    { 3, "Good.", 1, 3, 2 },
                    { 4, "Bad.", 2, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Screening",
                columns: new[] { "id", "category", "hall_id", "movie_id", "price", "screening_time" },
                values: new object[,]
                {
                    { 1, "4Dx", 1, 1, 12.50m, new DateTime(2024, 7, 24, 20, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, "3D", 2, 2, 15.00m, new DateTime(2024, 7, 24, 22, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Seat",
                columns: new[] { "id", "category", "hall_id", "seat_number", "status" },
                values: new object[,]
                {
                    { 1, "Single", 1, 1, true },
                    { 2, "Disabled", 1, 2, true },
                    { 3, "Disabled", 1, 3, true },
                    { 4, "Disabled", 1, 4, true },
                    { 5, "Single", 1, 5, true },
                    { 6, "Disabled", 1, 6, true },
                    { 7, "Single", 1, 7, true },
                    { 8, "Disabled", 1, 8, true },
                    { 9, "Single", 1, 9, true },
                    { 10, "Single", 1, 10, true },
                    { 11, "Single", 1, 11, true },
                    { 12, "Single", 1, 12, true },
                    { 13, "Single", 1, 13, true },
                    { 14, "Single", 1, 14, true },
                    { 15, "Single", 1, 15, true },
                    { 16, "Single", 1, 16, true },
                    { 17, "Single", 1, 17, true },
                    { 18, "Single", 1, 18, true },
                    { 19, "Single", 1, 19, true },
                    { 20, "Single", 1, 20, true },
                    { 21, "Single", 1, 21, true },
                    { 22, "Single", 1, 22, true },
                    { 23, "Single", 1, 23, true },
                    { 24, "Single", 1, 24, true },
                    { 25, "Single", 1, 25, true },
                    { 26, "Double", 1, 26, true },
                    { 27, "Single", 1, 27, true },
                    { 28, "Single", 1, 28, true },
                    { 29, "Single", 1, 29, true },
                    { 30, "Single", 1, 30, true },
                    { 31, "Single", 1, 31, true },
                    { 32, "Single", 1, 32, true },
                    { 33, "Single", 1, 33, true },
                    { 34, "Single", 1, 34, true },
                    { 35, "Single", 1, 35, true },
                    { 36, "Single", 1, 36, true },
                    { 37, "Single", 1, 37, true },
                    { 38, "Double", 1, 38, true },
                    { 39, "Single", 1, 39, true },
                    { 40, "Single", 1, 40, true },
                    { 41, "Single", 1, 41, true },
                    { 42, "Single", 1, 42, true },
                    { 43, "Single", 1, 43, true },
                    { 44, "Single", 1, 44, true },
                    { 45, "Double", 1, 45, true },
                    { 46, "Single", 1, 46, true },
                    { 47, "Single", 1, 47, true },
                    { 48, "Single", 1, 48, true },
                    { 49, "Single", 1, 49, true },
                    { 50, "Single", 1, 50, true },
                    { 51, "Double", 1, 51, true },
                    { 52, "Single", 1, 52, true },
                    { 53, "Single", 1, 53, true },
                    { 54, "Double", 1, 54, true },
                    { 55, "Single", 1, 55, true },
                    { 56, "Single", 1, 56, true },
                    { 57, "Single", 1, 57, true },
                    { 58, "Single", 1, 58, true },
                    { 59, "Single", 1, 59, true },
                    { 60, "Single", 1, 60, true },
                    { 61, "Double", 1, 61, true },
                    { 62, "Single", 1, 62, true },
                    { 63, "Double", 1, 63, true },
                    { 64, "Single", 1, 64, true },
                    { 65, "Double", 1, 65, true },
                    { 66, "Single", 1, 66, true },
                    { 67, "Single", 1, 67, true },
                    { 68, "Single", 1, 68, true },
                    { 69, "Double", 1, 69, true },
                    { 70, "Single", 1, 70, true },
                    { 71, "Single", 1, 71, true },
                    { 72, "Single", 1, 72, true },
                    { 73, "Single", 1, 73, true },
                    { 74, "Single", 1, 74, true },
                    { 75, "Double", 1, 75, true },
                    { 76, "Single", 1, 76, true },
                    { 77, "Single", 1, 77, true },
                    { 78, "Single", 1, 78, true },
                    { 79, "Single", 1, 79, true },
                    { 80, "Single", 1, 80, true },
                    { 81, "Single", 2, 1, true },
                    { 82, "Disabled", 2, 2, true },
                    { 83, "Disabled", 2, 3, true },
                    { 84, "Disabled", 2, 4, true },
                    { 85, "Single", 2, 5, true },
                    { 86, "Disabled", 2, 6, true },
                    { 87, "Single", 2, 7, true },
                    { 88, "Disabled", 2, 8, true },
                    { 89, "Single", 2, 9, true },
                    { 90, "Single", 2, 10, true },
                    { 91, "Single", 2, 11, true },
                    { 92, "Single", 2, 12, true },
                    { 93, "Single", 2, 13, true },
                    { 94, "Single", 2, 14, true },
                    { 95, "Single", 2, 15, true },
                    { 96, "Single", 2, 16, true },
                    { 97, "Single", 2, 17, true },
                    { 98, "Single", 2, 18, true },
                    { 99, "Single", 2, 19, true },
                    { 100, "Single", 2, 20, true },
                    { 101, "Single", 2, 21, true },
                    { 102, "Single", 2, 22, true },
                    { 103, "Single", 2, 23, true },
                    { 104, "Single", 2, 24, true },
                    { 105, "Single", 2, 25, true },
                    { 106, "Double", 2, 26, true },
                    { 107, "Single", 2, 27, true },
                    { 108, "Single", 2, 28, true },
                    { 109, "Single", 2, 29, true },
                    { 110, "Single", 2, 30, true },
                    { 111, "Single", 2, 31, true },
                    { 112, "Single", 2, 32, true },
                    { 113, "Single", 2, 33, true },
                    { 114, "Single", 2, 34, true },
                    { 115, "Single", 2, 35, true },
                    { 116, "Single", 2, 36, true },
                    { 117, "Single", 2, 37, true },
                    { 118, "Double", 2, 38, true },
                    { 119, "Single", 2, 39, true },
                    { 120, "Single", 2, 40, true },
                    { 121, "Single", 2, 41, true },
                    { 122, "Single", 2, 42, true },
                    { 123, "Single", 2, 43, true },
                    { 124, "Single", 2, 44, true },
                    { 125, "Double", 2, 45, true },
                    { 126, "Single", 2, 46, true },
                    { 127, "Single", 2, 47, true },
                    { 128, "Single", 2, 48, true },
                    { 129, "Single", 2, 49, true },
                    { 130, "Single", 2, 50, true },
                    { 131, "Double", 2, 51, true },
                    { 132, "Single", 2, 52, true },
                    { 133, "Single", 2, 53, true },
                    { 134, "Double", 2, 54, true },
                    { 135, "Single", 2, 55, true },
                    { 136, "Single", 2, 56, true },
                    { 137, "Single", 2, 57, true },
                    { 138, "Single", 2, 58, true },
                    { 139, "Single", 2, 59, true },
                    { 140, "Single", 2, 60, true },
                    { 141, "Double", 2, 61, true },
                    { 142, "Single", 2, 62, true },
                    { 143, "Double", 2, 63, true },
                    { 144, "Single", 2, 64, true },
                    { 145, "Double", 2, 65, true },
                    { 146, "Single", 2, 66, true },
                    { 147, "Single", 2, 67, true },
                    { 148, "Single", 2, 68, true },
                    { 149, "Double", 2, 69, true },
                    { 150, "Single", 2, 70, true },
                    { 151, "Single", 2, 71, true },
                    { 152, "Single", 2, 72, true },
                    { 153, "Single", 2, 73, true },
                    { 154, "Single", 2, 74, true },
                    { 155, "Double", 2, 75, true },
                    { 156, "Single", 2, 76, true },
                    { 157, "Single", 2, 77, true },
                    { 158, "Single", 2, 78, true },
                    { 159, "Single", 2, 79, true },
                    { 160, "Single", 2, 80, true }
                });

            migrationBuilder.InsertData(
                table: "Booking",
                columns: new[] { "id", "price", "promotion_Id", "screening_id", "user_id" },
                values: new object[,]
                {
                    { 1, 25.00m, 1, 1, 1 },
                    { 2, 30.00m, 2, 2, 1 }
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
                    { 1, 25.00m, 1, "successfully" },
                    { 2, 30.00m, 2, "successfully" }
                });

            migrationBuilder.InsertData(
                table: "Ticket",
                columns: new[] { "id", "booking_seat_id", "price", "qr_code", "ticket_code", "user_id" },
                values: new object[,]
                {
                    { 1, 1, 12.50m, "iVBORw0KGgoAAAANSUhEUgAAASwAAAEsCAYAAAB5fY51AAAABHNCSVQICAgIfAhkiAAACQpJREFUeJzt3UFuG7kWhtHrh+zLzMpCrczUyvIGdoCeNDq5VFj+5XMAoUcXrFIpX6MGpF+qanx8+Bxm0Jrdua5Rvd/q+vh0zOYcj7eq3h/IT59P8zltNK/z7YJrnc1rnRtrXv178PnHc/zffzwsgE9DsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwgxreN2VVV9wddxzP6cXi9sTF7a8ysjfVGc667ZnduR+c7/Spea+P3Ouv8DvivoLsjvWs215sba3a9Na91XHCtp5/jVzDLaQ3AsxMsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ixc1pD16hrNrF2zasv4Detet8Fn8ApH/9uXn0Bf2DV4ZMwrgrW6aNXdsyrL+A3rer9eEb1ThdYVfW9MVeV851eIenfRtXhYHklBGIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwgxhWnNfB3zOodL3OrqpfHXsp/mtW/1vXQKyGKYD2X0Zi51/kIvFbvWm8Pvg7CeCUEYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcSw+fl5zDq/iXk25+7NuVG9TdOrnPLwFATruazD6/1ozq3qhac25lZzjk/EKyEQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIbNz89jNOfW5mzHvfonNnSsg2vxF10RrFn9Y0n4d6N6pyes6h/Z0pmrqvrenJvNNe+VE62Xqy/gM/NKCMQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuI4bSG57Gq6nVj9k+dPG3hl1X9e+QJ7ATrR/VOB+DvGNU7yeBW/dMzfjbnukb1T2s47fR38yV4JQRiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIMbL1RdAtLfm3L3OHhNzq94ROsAT+dn8vB2em3/p/jnMKyEQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIMZLVY2Pz59azbkdp9dc1d/lPzfWHM3Z0+uth13F7/vRmLlvrDebc6P6/65Wc815eG7U+XusWRk77tN2+afc487caXPjWk/fY3fN0VxvNNdLukevhEAOwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGN8+/rsas90d8Ds75+/N+bUx13Vrzr02173V2Wey6ppTHjqzO7+bHZ35nTU7v7lVe6eDrOZcZ81VlXVaw1dwfAf8htPPcTbXmxtrdn2F53i6AdMrIRBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwgxrd63wH92pxfjZmd0xq+gqTvZ12wXve3etpXeI5XnNjSNqq/U/u0uXGtJ+euWHNnrqu75miuN5rr7TzH00bzOnee43FeCYEYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiPFtY3ZV1UtztrtD/Htzbn58/tRornev/rWeNppz9zr/HHesxkzSc6zq32P3Od6rd9zPrZpH2uwEa8e4aN2OcfUFHDAOz11hXH0BB4zDc93ZW3cxr4RADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBi7m59nc24150b1Nluu5prduar+d9OdG3X2u6nqn2Qw6vxzPH3qwqjnv8f74fW2jKr62fi8Ned2ZkfQPXbNw9faPZKkNtYcG2uelnSPKf8evRICOQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmLsntbQ+ZPTq/Z2eXdm18Z6V9xj12rM3Kv/nY7G3M6a1VxzNed+zXa4x8evxxOZ1ds5PzfWdCLF482Naz05t/Mc27wSAjEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJi7J7WwOexqur1gjVPr9e9x9WYuerEjWe/xy2z+ru1fR7/6ZrN9ebGmqfN6t3j28ZcV3fNsbFmV/e3evwevRICMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhDjpd53wP9ozN4qa6f/ad2TF14eehX/bVTv+d+r//xnnT0K51bnj8I5bVT/OXafxffmXJvzsKg6f6TJa3PN1Zy71/MHq6r/HLtzx3klBGIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEuGLz86zervKrnD49oWtUf0PxeuB1/I774bmq8yeLrDr7PFadPz1h1NmN08tpDc9jVO9/BDsnJ3R116zDc2tjvSu+1+7s28aaozGzmnNeCYEcggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMWx+fi6rMXPFyQn3zfnOet253fvsGI2Z1VxrZ7b7/azunGA9l3F4rmtuzI3mbHfu9JEts3qnbtyq/72O5tzOd7M6Q14JgRiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExbH5+Hqve/zx6d/ZPnTxt4ZdV7vFvrRlBsJ7HqP6xJJ25HW/NNVdzbuckg67uPX6v8ydEnF6vzSshEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExrjitYV2w5lexGjPdI1Tu9X4iQXe2ax2a2dW9xx8fn856nWNpunNVF5zycFWw1gXrfgUjZK47u5pz9zr/m3ut88f9nJ47zishEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCDGzubn16qaD7oO9q3q79bv6u7WH825nWudG7Md3Wu9fXy6syeN6m/wXt1FZ1X99Pk0n67ZXO9tY65rZ82EuZ3Z0f9a22Lu0SshEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCDGt/Jn45/F2pjtnCywu153ze4pCKfX21nztJ1THo7e4/8B5V3af+9gHn8AAAAASUVORK5CYII=", "E3DBB11CE45E", 1 },
                    { 2, 2, 12.50m, "iVBORw0KGgoAAAANSUhEUgAAASwAAAEsCAYAAAB5fY51AAAABHNCSVQICAgIfAhkiAAACLdJREFUeJzt3UFSHDsWhtHrDu8LeWVWrQzVyugBOPpNuttcgZK/OCci441uSEkVn18OUvyoqvF28TXM5tyo3ue43q4Eo87f42zO8fHWz3r9Avy+eCP8x2zOjep/jqs5d9qo8/fod+ML+dfVGwD4W4IFxBAsIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATF+bsyuqrp/0D4e0RUvza7mzDi4Xl2wXndux+2CNVM81cYJMbOqXhrX7O/3W+j8TF821pvN9Z435rq6a46NNbtOf47fwaxmczwSAjEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJi7JzW0DXqmpdYu+bVG/hLq17fgu/OvtfOSR1O+fjv5tUbeIdVh0/CuCpYVxy90jWv3sBfGtX7h2A156r6pxLsrNk5JeJWOZ9j0u9G1eFgeSQEYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCDGFac18HlWY+ZWVb+a63VOTqiN9WZzbjXn+GIE67GMxsy9+r/QnfV2ddbcuUe+EI+EQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYXn5+HLP6L/jO5lx3vVH9F6e7a/IABOuxrMbMqKrfzbVGY+6f655a896Y4QvySAjEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiOHl58cxNmZvjZm1sd69zr6QvA6uxSebVfXSuOb5rUbp/ExfNtabzfXmxpru8ePv8TuY1fwcPRICMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmI4reFxrKp6umDN0+udvke+kJ1g/X67+BpG9Y6Y2TnmpbPejtFc8+RRNn84seETeCQEYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLAAAAAAAAAAAAAAAAAAAAACAh/Sjqsbb9V6rOVdVNZtzXaPO32PXPLxeklH9z3F94D7+xqjze53Nua5VZ38/VtXrTb40rueNudPmxl5Pzr180v0/ilm9n+k8v9X2d2A01xvN9Xa+q6d/P6YD/IAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMX6+/Xc1Zu/NNe91/gSEqvP32J3tGs25FbZmZ3bV+e9c9zuwNta8HV5v5x7bP5tZGW9qX7Hmztxps7nXubFm93Psms31rviuJom5R4+EQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYP+v1Dein5vxqzOycYrBzekLXOrxe16r+57iz5un1Ur6rSdbVGzhhVM5JBl2jvOX/lcxyIsUj3GObR0IghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiCFYQAzBAmL83JhdVfXjg/bx2Wb1jiW5V/9Ykl+Nuar+Xm+Vc0zIrLPHxFT1Tgm5V/87Pqv/Oc7G3Kjz99g1q/mz2QlWmnF4ruupuebtg/fxmbr3uJpztTHXdcXn2FnvKqMxc/dICMQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIcdVpC/PwXNX5F0N31uueLNGx6pqXZrsnGXT9bs7t/FxPzlX1Tmuo6p8sMqr/3Tn5Hd/20rySdO/x+cHndmbHez6AfxgX3ONpo7nP5401T393pkdCIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWECMq/5UfdKfVe/auceTb6V317pvzO6sO5pznc9jNde6SvceR3O97ndgbczxIGadP63htNnc69xYM+W0hh0x9+iREIghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMwQJiCBYQ46rTGvh4q6qeNmbf6+SJEn+s6t/jzpqPbl29gfeY1X9b2/Xx12mjuc/n5tzO7LjgHk+bzb3OjTVTvqseCYEcggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiLFzvMyt9t4Qf3Sn32af1Tt65VZVPz52K//XbM79frve66p77HweVb3jXjozf5z+2bQ5D+uxjMbMvc6fh/RUvb2u5px7fBAeCYEYggXEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMa54+XlW7437q6S8yb6qfzrAPDx3Pzx3he5eb2/XSfPwXJvTGh7HqN5b/n9m32s116rqn2RQzbkrQte9x1udP3Wh+z8Q8yM38Tc8EgIxBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYnj5+XGsw+vtvFB835x/r7UxO5pz3XtczfWq+nvtrtldr2tVvb5x/dK4ZnPR7npXXV2n1+sazX0+X7DX2dzr3FjzO3yO3XvsznbnpkdCIIZgATEEC4ghWEAMwQJiCBYQQ7CAGIIFxBAsIIZgATEEC4ghWEAMpzVQ1Xtb/4o//77q9U/An14zxWrM7J66cXKuqpzW8Flv3ae85b/jO9zjabPOn5wQwyMhEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBiCBcQQLCCGYAExrjheZl2w5ncwq3f0yn1jbjXmqvp7vW2smWQ1Zm5V9euD9/HlXBWsdcG638EImevO3jbWSzIaMzv/gMTwSAjEECwghmABMQQLiCFYQAzBAmIIFhBDsIAYggXEECwghmABMQQLiLHz8vNTvb51z9ewqn/qQlf3dICxMdeZXZXzYvCs83udh+dG9T/HmlX14voyV9dsrve8Mde1s2Znbm7s9TtI+a5Oj4RADMECYggWEEOwgBiCBcQQLCCGYAExBAuIIVhADMECYggWEEOwgBg/K+ctdv63tTHbObFhd73umqf3+h3cDq+3unP/BpFysxQNCNFeAAAAAElFTkSuQmCC", "233DADBBE44F", 1 },
                    { 3, 3, 15.00m, "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", "E3BA0200440C", 2 },
                    { 4, 4, 15.00m, "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", "03DD405DBBAE", 2 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Booking_promotion_Id",
                table: "Booking",
                column: "promotion_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Booking_screening_id",
                table: "Booking",
                column: "screening_id");

            migrationBuilder.CreateIndex(
                name: "IX_Booking_user_id",
                table: "Booking",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeat_booking_id",
                table: "BookingSeat",
                column: "booking_id");

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeat_seat_id",
                table: "BookingSeat",
                column: "seat_id");

            migrationBuilder.CreateIndex(
                name: "IX_Hall_cinema_id",
                table: "Hall",
                column: "cinema_id");

            migrationBuilder.CreateIndex(
                name: "IX_Movie_genre_id",
                table: "Movie",
                column: "genre_id");

            migrationBuilder.CreateIndex(
                name: "IX_MovieActor_actor_id",
                table: "MovieActor",
                column: "actor_id");

            migrationBuilder.CreateIndex(
                name: "IX_MovieActor_movie_id",
                table: "MovieActor",
                column: "movie_id");

            migrationBuilder.CreateIndex(
                name: "IX_News_cinema_id",
                table: "News",
                column: "cinema_id");

            migrationBuilder.CreateIndex(
                name: "IX_Payment_booking_id",
                table: "Payment",
                column: "booking_id");

            migrationBuilder.CreateIndex(
                name: "IX_Review_movie_id",
                table: "Review",
                column: "movie_id");

            migrationBuilder.CreateIndex(
                name: "IX_Review_user_id",
                table: "Review",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "IX_Screening_hall_id",
                table: "Screening",
                column: "hall_id");

            migrationBuilder.CreateIndex(
                name: "IX_Screening_movie_id",
                table: "Screening",
                column: "movie_id");

            migrationBuilder.CreateIndex(
                name: "IX_Seat_hall_id",
                table: "Seat",
                column: "hall_id");

            migrationBuilder.CreateIndex(
                name: "IX_Ticket_user_id",
                table: "Ticket",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "UQ__Ticket__C073D47C7F315E70",
                table: "Ticket",
                column: "booking_seat_id",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UsersRoles_role_id",
                table: "UsersRoles",
                column: "role_id");

            migrationBuilder.CreateIndex(
                name: "IX_UsersRoles_user_id",
                table: "UsersRoles",
                column: "user_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MovieActor");

            migrationBuilder.DropTable(
                name: "News");

            migrationBuilder.DropTable(
                name: "Payment");

            migrationBuilder.DropTable(
                name: "Review");

            migrationBuilder.DropTable(
                name: "Ticket");

            migrationBuilder.DropTable(
                name: "UsersRoles");

            migrationBuilder.DropTable(
                name: "Actor");

            migrationBuilder.DropTable(
                name: "BookingSeat");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Booking");

            migrationBuilder.DropTable(
                name: "Seat");

            migrationBuilder.DropTable(
                name: "Promotion");

            migrationBuilder.DropTable(
                name: "Screening");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "Hall");

            migrationBuilder.DropTable(
                name: "Movie");

            migrationBuilder.DropTable(
                name: "Cinema");

            migrationBuilder.DropTable(
                name: "Genre");
        }
    }
}
