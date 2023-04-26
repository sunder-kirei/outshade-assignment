import 'package:outshade_assignment/models/enums.dart';

class DbData {
  final int uid;
  final int age;
  final Gender gender;

  const DbData({
    required this.uid,
    required this.age,
    required this.gender,
  });

  factory DbData.fromMap({required Map<String, dynamic> dataMap}) {
    return DbData(
      uid: dataMap["uid"],
      age: dataMap["age"],
      gender: Gender.values[dataMap["gender"]],
    );
  }

  Map<String, int> get dataMap {
    return {
      "uid": uid,
      "age": age,
      "gender": gender.index,
    };
  }
}
