class User {
  final String name;
  final int id;
  final String atype;

  int? age;
  int? gender;

  User({
    required this.name,
    required this.id,
    required this.atype,
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

  set setAge(int age) {
    this.age = age;
    return;
  }

  set setGender(int gender) {
    this.gender = gender;
    return;
  }
}
