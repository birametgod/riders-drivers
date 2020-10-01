import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridersdrivers_app/constants.dart';
import 'package:ridersdrivers_app/widgets/button_radius.dart';
import 'package:ridersdrivers_app/widgets/google_font_bold_one.dart';
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
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ButtonRadius(
                          colorShadowBox: gradientFirst,
                          colorDecorationBox: gradientSecond,
                          element: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: TextFittedBox(
                              text: GoogleFontBoldOne(
                                size: 15.0,
                                textValue:
                                'Continuer avec un numéro de téléphone',
                              ),
                            ),
                          ),
                        ),
                        ButtonRadius(
                          colorDecorationBox: facebookColorLight,
                          colorShadowBox: facebookColor,
                          element: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Container(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/facebookIcon.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              TextFittedBox(
                                text: GoogleFontBoldOne(
                                    textValue: 'Continuer avec facebook',
                                    size: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Get\na ride\nin minutes',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    height: 1.2,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                          ),
                          Text(
                            "You'll be on your way in no time",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white
                                    //fontWeight: FontWeight.bold
                                    )),
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
