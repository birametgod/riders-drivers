import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'login.dart';
import 'welcome.dart';
import 'theme.dart';
import 'gmap.dart';
import 'navbar.dart';
import 'myPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Slider(),
      //home: LoginPage(),
      //home: Scaffold(
        //body: GMap(),
      //),
      home: ExtendedNavBar(),
    );
  }
}
