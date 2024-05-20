import 'package:cinebox_mobile/providers/actor_provider.dart';
import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/cinema_provider.dart';
import 'package:cinebox_mobile/providers/hall_provider.dart';
import 'package:cinebox_mobile/providers/logged_in_user_provider.dart';
import 'package:cinebox_mobile/providers/movie_actor_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/providers/promotion_provider.dart';
import 'package:cinebox_mobile/providers/review_provider.dart';
import 'package:cinebox_mobile/providers/screening_provider.dart';
import 'package:cinebox_mobile/providers/seat_provider.dart';
import 'package:cinebox_mobile/providers/users_provider.dart';
import 'package:cinebox_mobile/screens/Cart/cart_screen.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/screens/Promotion/promotion_screen.dart';
import 'package:cinebox_mobile/screens/cinema_screen.dart';
import 'package:cinebox_mobile/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ActorProvider()),
        ChangeNotifierProvider(create: (_) => MovieActorProvider()),
        ChangeNotifierProvider(create: (_) => ScreeningProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => LoggedInUserProvider()),
        ChangeNotifierProvider(create: (_) => CinemaProvider()),
        ChangeNotifierProvider(create: (_) => HallProvider()),
        ChangeNotifierProvider(create: (_) => PromotionProvider()),
        ChangeNotifierProvider(create: (_) => SeatProvider()),
      ],
      child: MyMaterialApp(),
    ));

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      onGenerateRoute: (settings) {
        if (settings.name == MovieListScreen.routeName) {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          final cinemaId = args['cinemaId'] as int;
          final initialDate = args['initialDate'] as DateTime;
          final cinemaName = args['cinemaName'] as String;
          return MaterialPageRoute(
            builder: (context) => MovieListScreen(
                cinemaId: cinemaId,
                initialDate: initialDate,
                cinemaName: cinemaName),
          );
        }
        if (settings.name == CartScreen.routeName) {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          final cinemaId = args['cinemaId'] as int;
          final initialDate = args['initialDate'] as DateTime;
          final cinemaName = args['cinemaName'] as String;
          return MaterialPageRoute(
              builder: (context) => CartScreen(
                  cinemaId: cinemaId,
                  initialDate: initialDate,
                  cinemaName: cinemaName));
        }
        if (settings.name == CinemaScreen.routeName) {
          return MaterialPageRoute(builder: (context) => CinemaScreen());
        }
        if (settings.name == PromotionScreen.routeName) {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          final cinemaId = args['cinemaId'] as int;
          final initialDate = args['initialDate'] as DateTime;
          final cinemaName = args['cinemaName'] as String;
          return MaterialPageRoute(
              builder: (context) => PromotionScreen(
                  cinemaId: cinemaId,
                  initialDate: initialDate,
                  cinemaName: cinemaName));
        }
        return null;
      },
    );
  }
}
