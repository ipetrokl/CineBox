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
        title: Builder(
          builder: (context) {
            return Text(
              context.watch<NavigatorProvider>().activeTitle ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        backgroundColor: const Color.fromRGBO(198, 195, 206, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(198, 195, 206, 1),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreeningListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Cinema",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CinemaListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Actor",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ActorListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Booking",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BookingListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Genre",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GenreListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Hall",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HallListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PaymentListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Promotion",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PromotionListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Review",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ReviewListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Seat",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SeatListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Ticket",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TicketListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Users",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UsersListScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Role",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RoleListScreen(),
                        ),
                      );
                    },
                  ),
                  if(user.roles.contains(1)) ListTile(
                    title: const Text(
                      "UsersRole",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UsersRoleListScreen(),
                        ),
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
