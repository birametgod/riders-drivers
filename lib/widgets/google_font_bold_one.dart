import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridersdrivers_app/constants.dart';

class GoogleFontBoldOne extends StatelessWidget {

  const GoogleFontBoldOne({@required this.textValue, @required this.size}) ;

  final String textValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: GoogleFonts.poppins(
        color: gradientEnd,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}