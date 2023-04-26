import 'package:flutter/material.dart';
import 'package:outshade_assignment/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: HomeScreen(),
        // routes: {
        //   HomeScreen.routeName: (context) => const HomeScreen(),
        // },
      ),
    );
  }
}
