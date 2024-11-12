import 'dart:ui';

import 'package:cinebox_desktop/providers/actor_provider.dart';
import 'package:cinebox_desktop/providers/admin_provider.dart';
import 'package:cinebox_desktop/providers/booking_provider.dart';
import 'package:cinebox_desktop/providers/booking_seat_provider.dart';
import 'package:cinebox_desktop/providers/cinema_provider.dart';
import 'package:cinebox_desktop/providers/genre_provider.dart';
import 'package:cinebox_desktop/providers/hall_provider.dart';
import 'package:cinebox_desktop/providers/movie_actor_provider.dart';
import 'package:cinebox_desktop/providers/movie_provider.dart';
import 'package:cinebox_desktop/providers/news_provider.dart';
import 'package:cinebox_desktop/providers/payment_provider.dart';
import 'package:cinebox_desktop/providers/picture_provider.dart';
import 'package:cinebox_desktop/providers/promotion_provider.dart';
import 'package:cinebox_desktop/providers/review_provider.dart';
import 'package:cinebox_desktop/providers/role_provider.dart';
import 'package:cinebox_desktop/providers/screening_provider.dart';
import 'package:cinebox_desktop/providers/seat_provider.dart';
import 'package:cinebox_desktop/providers/ticket_provider.dart';
import 'package:cinebox_desktop/providers/usersRole_provider.dart';
import 'package:cinebox_desktop/providers/users_provider.dart';
import 'package:cinebox_desktop/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/navigator_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavigatorProvider()),
      ChangeNotifierProvider(create: (_) => IsAdminCheckProvider()),
      ChangeNotifierProvider(create: (_) => MovieProvider()),
      ChangeNotifierProvider(create: (_) => CinemaProvider()),
      ChangeNotifierProvider(create: (_) => ScreeningProvider()),
      ChangeNotifierProvider(create: (_) => GenreProvider()),
      ChangeNotifierProvider(create: (_) => ActorProvider()),
      ChangeNotifierProvider(create: (_) => MovieActorProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      ChangeNotifierProvider(create: (_) => HallProvider()),
      ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ChangeNotifierProvider(create: (_) => PromotionProvider()),
      ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ChangeNotifierProvider(create: (_) => SeatProvider()),
      ChangeNotifierProvider(create: (_) => TicketProvider()),
      ChangeNotifierProvider(create: (_) => UsersProvider()),
      ChangeNotifierProvider(create: (_) => RoleProvider()),
      ChangeNotifierProvider(create: (_) => UsersRoleProvider()),
      ChangeNotifierProvider(create: (_) => NewsProvider()),
      ChangeNotifierProvider(create: (_) => PictureProvider()),
      ChangeNotifierProvider(create: (_) => BookingSeatProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyMaterialScrollBehavior(),
      title: 'Cinebox Material app',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(180, 186, 177, 1),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}

class MyMaterialScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return Scrollbar(
      controller: details.controller,
      child: child,
    );
  }
}
