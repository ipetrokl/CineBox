import 'package:cinebox_mobile/providers/booking_provider.dart';
import 'package:cinebox_mobile/providers/cart_provider.dart';
import 'package:cinebox_mobile/providers/movie_provider.dart';
import 'package:cinebox_mobile/screens/Cart/cart_screen.dart';
import 'package:cinebox_mobile/screens/Movies/movie_list_screen.dart';
import 'package:cinebox_mobile/screens/log_in_screen.dart';
import 'package:cinebox_mobile/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
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
          return MaterialPageRoute(builder: (context) => MovieListScreen());
        }
        if (settings.name == CartScreen.routeName) {
          return MaterialPageRoute(builder: (context) => CartScreen());
        }
        // Dodajte ostale rute ovdje po potrebi
      },
    );
  }
}
