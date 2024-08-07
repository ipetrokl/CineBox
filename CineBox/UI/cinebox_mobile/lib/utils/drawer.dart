import 'package:cinebox_mobile/screens/News/news_screen.dart';
import 'package:cinebox_mobile/screens/Promotion/promotion_screen.dart';
import 'package:cinebox_mobile/screens/Support/support_screen.dart';
import 'package:cinebox_mobile/screens/cinema_screen.dart';
import 'package:flutter/material.dart';

class CineboxDrawer extends StatelessWidget {
  final int cinemaId;
  final DateTime initialDate;
  final String cinemaName;

  const CineboxDrawer(
      {super.key,
      required this.cinemaId,
      required this.initialDate,
      required this.cinemaName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(97, 72, 199, 1),
      width: MediaQuery.of(context).size.width * 0.5,
      child: ListView(
        children: [
          ListTile(
            textColor: Colors.white,
            title: const Text('Cinema'),
            onTap: () {
              Navigator.pushNamed(context, CinemaScreen.routeName);
            },
          ),
          ListTile(
            textColor: Colors.white,
            title: const Text("Promo codes"),
            onTap: () {
              Navigator.pushNamed(context, PromotionScreen.routeName,
                  arguments: {
                    'cinemaId': cinemaId,
                    'initialDate': initialDate,
                    'cinemaName': cinemaName
                  });
            },
          ),
          ListTile(
            textColor: Colors.white,
            title: const Text("News"),
            onTap: () {
              Navigator.pushNamed(context, NewsScreen.routeName, arguments: {
                'cinemaId': cinemaId,
                'initialDate': initialDate,
                'cinemaName': cinemaName
              });
            },
          ),
          ListTile(
            textColor: Colors.white,
            title: const Text("Support"),
            onTap: () {
              Navigator.pushNamed(context, SupportScreen.routeName, arguments: {
                'cinemaId': cinemaId,
                'initialDate': initialDate,
                'cinemaName': cinemaName
              });
            },
          ),
        ],
      ),
    );
  }
}
