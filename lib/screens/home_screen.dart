import 'package:flutter/material.dart';
import 'package:outshade_assignment/models/enums.dart';
import 'package:outshade_assignment/providers/auth_provider.dart';
import 'package:outshade_assignment/repos/api_repo.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    final signInHandler = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signIn;
    final signOutHandler = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signOut;

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
              final data = userList[index];
              return ListTile(
                key: ValueKey(data.id),
                title: Text(
                  data.name,
                ),
                trailing: Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    bool isSignedIn = value.isSignedIn(uid: data.id);
                    return TextButton(
                      onPressed: () {
                        isSignedIn
                            ? signOutHandler(user: data)
                            : signInHandler(
                                age: 18,
                                gender: Gender.male,
                                user: data,
                              );
                      },
                      child: isSignedIn ? Text("Sign Out") : Text("Sign In"),
                    );
                  },
                ),
              );
            },
            itemCount: userList!.length,
          );
        },
        future: ApiRepo.getUsers,
      ),
    );
  }
}
