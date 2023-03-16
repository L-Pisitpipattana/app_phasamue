import 'package:app_phasamue/screens/capimg.dart';
import 'package:app_phasamue/screens/category.dart';
import 'package:app_phasamue/screens/onboarding.dart';
import 'package:app_phasamue/screens/socket.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: const FirebaseOptions(
    apiKey: "AIzaSyDaC-AXKLSIO50W6bfjTNINcytDB4dmtMY",
    appId: "1:469913225378:android:4caa7fa9b4e0590b082ffb",
    databaseURL: "https://phasamue-b51ba-default-rtdb.asia-southeast1.firebasedatabase.app",
    messagingSenderId: "469913225378",
    projectId: "phasamue-b51ba", ), );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        //scaffoldBackgroundColor: Colors.white,
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.pink),
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
