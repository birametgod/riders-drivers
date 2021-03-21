import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ridersdrivers_app/screens/connexion_screen.dart';
import 'package:ridersdrivers_app/screens/geolocation_screen.dart';
import 'package:ridersdrivers_app/screens/identication_screen.dart';
import 'package:ridersdrivers_app/screens/welcome_screen.dart';
import 'package:ridersdrivers_app/screens/verify_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride & Drivers Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}


