import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(232, 77, 13, 151),
                Color.fromARGB(255, 119, 25, 182),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/quiz-logo.png",
                width: 250,
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(
                height: 60,
              ),
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
