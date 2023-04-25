import 'package:outshade_assignment/models/user.dart';
import '../data/json_data.dart';

class ApiRepo {
  static Future<List<User>> get getUsers async {
    final jsonData = await JsonData.data;
    final jsonUserList = jsonData[0]["users"];

    if (jsonUserList == null) {
      return [];
    }

    return jsonUserList
        .map(
          (data) => User.fromMap(dataMap: data),
        )
        .toList();
  }
}
