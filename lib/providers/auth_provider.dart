import 'package:flutter/material.dart';
import 'package:outshade_assignment/models/db_model.dart';
import 'package:outshade_assignment/models/enums.dart';
import 'package:outshade_assignment/models/user.dart';
import 'package:outshade_assignment/utils/db_helper.dart';

class AuthProvider with ChangeNotifier {
  List<DbData> signedInUsers = [];

  AuthProvider() {
    _syncAuthList();
  }

  Future<void> _syncAuthList() async {
    final dbResponse = await DBHelper.allUsers;
    signedInUsers = dbResponse;
    notifyListeners();
    return;
  }

  bool isSignedIn({required int uid}) {
    return signedInUsers.indexWhere(
          (element) => element.uid == uid,
        ) !=
        -1;
  }

  Future<void> signIn({
    required int age,
    required Gender gender,
    required User user,
  }) async {
    user.age = age;
    user.gender = gender.index;
    await DBHelper.insert(
      data: DbData(
        uid: user.id,
        age: age,
        gender: gender,
      ),
    );
    _syncAuthList();
    return;
  }

  Future<void> signOut({
    required User user,
  }) async {
    final foundUser = signedInUsers.indexWhere(
      (element) => element.uid == user.id,
    );
    if (foundUser == -1) {
      return;
    }

    final dbData = await DBHelper.getUserByUID(uid: user.id);
    if (dbData == null) {
      return;
    }
    DBHelper.remove(
      data: dbData,
    );
    _syncAuthList();
    return;
  }
}
