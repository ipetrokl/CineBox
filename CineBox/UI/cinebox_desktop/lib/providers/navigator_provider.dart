import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  Widget? activeScreen;
  String? activeTitle;

  void navigate({required Widget screen, required String title}) {
    activeScreen = screen;
    activeTitle = title;
    notifyListeners();
  }
}
