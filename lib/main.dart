import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ridersdrivers_app/screens/connexion_screen.dart';
import 'package:ridersdrivers_app/screens/geolocation_screen.dart';
import 'package:ridersdrivers_app/screens/verify_screen_second.dart';

void main() {
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
      home: ConnexionScreen(),
    );
  }
}


