import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier {
  /// data
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
