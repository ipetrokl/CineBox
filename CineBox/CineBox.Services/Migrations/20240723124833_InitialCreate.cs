using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

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
