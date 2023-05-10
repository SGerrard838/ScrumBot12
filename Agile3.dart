import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_application_1/Intro.dart';

class MyWelcome extends StatelessWidget {
  const MyWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.network("https://img.freepik.com/premium-vector/monitor-vector_122446-20.jpg?w=826"),
        nextScreen: MyIntro(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}