import 'package:flutter/material.dart';
import 'package:outshade_assignment/providers/user.dart';
import 'package:outshade_assignment/repos/api_repo.dart';
import 'package:outshade_assignment/utils/db_helper.dart';

class Users with ChangeNotifier {
  List<User> _userList = [];

  Future<List<User>> get users async {
    var userList = await ApiRepo.getUsers;
    var signedInUser = await DBHelper.allUsers;
    return userList.map((element) {
      final foundUser = signedInUser.indexWhere(
        (dbElement) => dbElement.uid == element.id,
      );
      if (foundUser != -1) {
        element.isSignedIn = true;
        element.age = signedInUser[foundUser].age;
        element.gender = signedInUser[foundUser].gender;
      }
      return element;
    }).toList();
  }
}
