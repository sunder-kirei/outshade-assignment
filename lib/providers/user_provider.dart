import 'package:flutter/material.dart';
import 'package:outshade_assignment/models/user.dart';
import 'package:outshade_assignment/repos/api_repo.dart';

class UserProvider extends ChangeNotifier {
  List<User> _userList = [];

  UserProvider() {
    ApiRepo.getUsers.then((userList) {
      _userList = userList;
      notifyListeners();
    });
  }

  List<User> get getUsers {
    return [..._userList];
  }
}
