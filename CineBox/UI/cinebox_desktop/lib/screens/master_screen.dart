import 'package:cinebox_desktop/models/Cinema/cinema.dart';
import 'package:cinebox_desktop/screens/ActorScreens/actor_list_screen.dart';
import 'package:cinebox_desktop/screens/BookingScreens/booking_list_screen.dart';
import 'package:cinebox_desktop/screens/CinemaScreens/cinema_list_screen.dart';
import 'package:cinebox_desktop/screens/GenreScreens/genre_list_screen.dart';
import 'package:cinebox_desktop/screens/HallScreens/hall_list_screen.dart';
import 'package:cinebox_desktop/screens/PaymentScreens/payment_list_screen.dart';
import 'package:cinebox_desktop/screens/PromotionScreens/promotion_list_screen.dart';
import 'package:cinebox_desktop/screens/ReviewScreens/review_list_screen.dart';
import 'package:cinebox_desktop/screens/RoleScreens/role_list_screen.dart';
import 'package:cinebox_desktop/screens/ScreeningScreens/screening_list_screen.dart';
import 'package:cinebox_desktop/screens/SeatScreens/seat_list_screen.dart';
import 'package:cinebox_desktop/screens/TicketScreens/ticket_list_screen.dart';
import 'package:cinebox_desktop/screens/UsersRoleScreens/usersRole_list_screen.dart';
import 'package:cinebox_desktop/screens/UsersScreens/users_list_screen.dart';
import 'package:cinebox_desktop/screens/log_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigator_provider.dart';
import 'MovieScreens/movie_list_screen.dart';

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
        title: const Text(
          "CineBox",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Tooltip(
            message:
                'Sign out', // Tekst koji će se prikazati kada korisnik drži prst iznad ikone
            child: IconButton(
              iconSize: 28,
              padding: EdgeInsets.only(right: 35),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(184, 182, 173, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Material(
              color: const Color.fromRGBO(184, 182, 173, 1),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const MovieListScreen(),
                            title: 'Movies',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Screening",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const ScreeningListScreen(),
                            title: 'Screenings',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Cinema",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const CinemaListScreen(),
                            title: 'Cinemas',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Actor",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const ActorListScreen(),
                            title: 'Actors',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Booking",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const BookingListScreen(),
                            title: 'Bookings',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Genre",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const GenreListScreen(),
                            title: 'Genres',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Hall",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const HallListScreen(),
                            title: 'Halls',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const PaymentListScreen(),
                            title: 'Payments',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Promotion",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const PromotionListScreen(),
                            title: 'Promotions',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Review",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const ReviewListScreen(),
                            title: 'Reviews',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Seat",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const SeatListScreen(),
                            title: 'Seats',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Ticket",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const TicketListScreen(),
                            title: 'Tickets',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Users",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const UsersListScreen(),
                            title: 'Users',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Role",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const RoleListScreen(),
                            title: 'Roles',
                          );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "UsersRole",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      context.read<NavigatorProvider>().navigate(
                            screen: const UsersRoleListScreen(),
                            title: 'Users Roles',
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 3,
            child: MasterScreenContent(),
          ),
        ],
      ),
    );
  }
}

class MasterScreenContent extends StatelessWidget {
  const MasterScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return context.watch<NavigatorProvider>().activeScreen ?? const SizedBox();
  }
}
