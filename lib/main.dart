import 'package:flutter/material.dart';
import 'package:quiz_app/screens/auth_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Quiz",
      theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 78, 13, 151))),
      home: const AuthScreen(),
    );
  }
}
