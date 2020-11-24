import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridersdrivers_app/constants.dart';
import 'package:ridersdrivers_app/widgets/button_radius.dart';
import 'package:ridersdrivers_app/widgets/google_font_one.dart';
import 'package:ridersdrivers_app/widgets/text_fitted_box.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/lac_rose.jpeg'),
          fit: BoxFit.cover,
        )),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GoogleFontOne(
                            textValue: 'Get\na ride\nin minutes' ,
                            size: 40.0,
                            weight:  FontWeight.w800 ,
                            height: 1.2
                          ),
                          GoogleFontOne(
                              textValue: "You'll be on your way in no time" ,
                              size: 20.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
