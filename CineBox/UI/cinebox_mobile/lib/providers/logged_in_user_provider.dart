import 'package:cinebox_mobile/models/Users/users.dart';
import 'package:flutter/material.dart';

class LoggedInUserProvider extends ChangeNotifier {
  Users? _loggedInUser;

  void setUser(Users user) {
    _loggedInUser = user;
    notifyListeners();
  }

  Users? get user => _loggedInUser;
}