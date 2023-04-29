import 'package:flutter/material.dart';
import 'package:outshade_assignment/models/enums.dart';

import '../providers/user.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          UserDetailTile(
            heading: "Name",
            title: user.name,
          ),
          UserDetailTile(
            heading: "Age",
            title: user.age.toString(),
          ),
          UserDetailTile(
            heading: "Gender",
            title: user.gender?.title ?? Gender.prefer_not_to_say.title,
          ),
        ],
      ),
    );
  }
}

class UserDetailTile extends StatelessWidget {
  const UserDetailTile({
    super.key,
    required this.title,
    required this.heading,
  });

  final String title;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(heading),
      title: Text(title),
    );
  }
}
