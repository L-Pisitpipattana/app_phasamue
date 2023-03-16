import 'package:app_phasamue/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/images/christmas-wreath.png',
      ),
      nextScreen: Home(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.amber,
    );
  }
}
