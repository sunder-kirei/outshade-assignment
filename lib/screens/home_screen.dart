import 'package:flutter/material.dart';
import 'package:outshade_assignment/models/enums.dart';
import 'package:outshade_assignment/providers/user.dart';
import 'package:outshade_assignment/repos/api_repo.dart';
import 'package:outshade_assignment/screens/auth_screen.dart';
import 'package:outshade_assignment/screens/user_screen.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final userList = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: userList[index],
                builder: (context, child) {
                  final data = Provider.of<User>(context);
                  final isSignedIn = data.isSignedIn;
                  final signOutHandler = data.signOut;
                  return ListTile(
                    key: ValueKey(data.id),
                    title: Text(
                      data.name,
                    ),
                    onTap: isSignedIn
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserScreen(user: data),
                              ),
                            );
                          }
                        : null,
                    trailing: TextButton(
                      onPressed: () {
                        isSignedIn
                            ? signOutHandler()
                            : Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AuthScreen(
                                    user: data,
                                  ),
                                ),
                              );
                      },
                      child: isSignedIn ? Text("Sign Out") : Text("Sign In"),
                    ),
                  );
                },
              );
            },
            itemCount: userList!.length,
          );
        },
        future: Provider.of<Users>(context).users,
      ),
    );
  }
}
