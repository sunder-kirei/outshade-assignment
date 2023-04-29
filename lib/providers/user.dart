import 'package:flutter/material.dart';

import '../models/db_model.dart';
import '../models/enums.dart';
import '../utils/db_helper.dart';

class User with ChangeNotifier {
  final String name;
  final int id;
  final String atype;
  bool isSignedIn;

  int? age;
  Gender? gender;

  User({
    required this.name,
    required this.id,
    required this.atype,
    this.isSignedIn = false,
    this.age,
    this.gender,
  });

  factory User.fromMap({required Map<String, String> dataMap}) {
    return User(
      atype: dataMap["atype"] ?? "unknown",
      id: int.parse(dataMap["id"] ?? "-1"),
      name: dataMap["name"] ?? "unknown",
    );
  }

  Future<void> signIn({required int age, required Gender gender}) async {
    this.age = age;
    this.gender = gender;
    isSignedIn = true;
    await DBHelper.insert(
      data: DbData(
        uid: id,
        age: age,
        gender: gender,
      ),
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    final dbData = await DBHelper.getUserByUID(uid: id);
    if (dbData == null) {
      return;
    }
    await DBHelper.remove(
      data: dbData,
    );
    isSignedIn = false;
    notifyListeners();
  }
}
