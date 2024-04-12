import 'package:cinebox_desktop/models/Genre/genre.dart';
import 'package:cinebox_desktop/models/search_result.dart';
import 'package:cinebox_desktop/providers/base_provider.dart';
import 'package:cinebox_desktop/screens/ActorScreens/actor_list_screen.dart';
import 'package:cinebox_desktop/screens/BookingScreens/booking_list_screen.dart';
import 'package:cinebox_desktop/screens/CinemaScreens/cinema_list_screen.dart';
import 'package:cinebox_desktop/screens/GenreScreens/genre_list_screen.dart';
import 'package:cinebox_desktop/screens/HallScreens/hall_list_screen.dart';
import 'package:cinebox_desktop/screens/MovieScreens/movie_list_screen.dart';
import 'package:cinebox_desktop/screens/PaymentScreens/payment_list_screen.dart';
import 'package:cinebox_desktop/screens/PromotionScreens/promotion_list_screen.dart';
import 'package:cinebox_desktop/screens/ReviewScreens/review_list_screen.dart';
import 'package:cinebox_desktop/screens/RoleScreens/role_list_screen.dart';
import 'package:cinebox_desktop/screens/ScreeningScreens/screening_list_screen.dart';
import 'package:cinebox_desktop/screens/SeatScreens/seat_list_screen.dart';
import 'package:cinebox_desktop/screens/TicketScreens/ticket_list_screen.dart';
import 'package:cinebox_desktop/screens/UsersRoleScreens/usersRole_list_screen.dart';
import 'package:cinebox_desktop/screens/UsersScreens/users_list_screen.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
        backgroundColor: Colors.blue,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200], // Boja bočnog izbornika
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Movies"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MovieListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Screening"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreeningListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Cinema"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CinemaListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Actor"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActorListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Booking"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Genre"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GenreListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Hall"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HallListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Payment"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Promotion"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PromotionListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Review"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReviewListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Seat"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SeatListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Ticket"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TicketListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Users"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UsersListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Role"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RoleListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text("UsersRole"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UsersRoleListScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget.child!,
          ),
        ],
      ),
    );
  }
}
