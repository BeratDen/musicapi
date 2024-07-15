import 'package:flutter/material.dart';
import 'package:music_app_gui/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void initUser(User user) {
    _user = user;
    debugPrint(this.user.toString());
    notifyListeners();
  }
}
