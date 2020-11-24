import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridersdrivers_app/constants.dart';
import 'package:ridersdrivers_app/widgets/button_radius.dart';
import 'package:ridersdrivers_app/widgets/google_font_one.dart';
import 'package:ridersdrivers_app/widgets/text_fitted_box.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: homeBodyDecoration,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                        color: gradientEnd,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextFittedBox(
                        text: GoogleFontOne(
                          size: 20.0,
                          textValue: "C'est quoi votre numéro ?",
                          spacing: 1.0,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextFittedBox(
                        text: GoogleFontOne(
                            size: 12.0,
                            textValue: "Veuillez entrer votre numéro. Seuls les conducteurs \n qui vous sont assignés verront votre numéro.",
                            spacing: 1.0,
                            weight: FontWeight.w500,
                            height: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      elevation: 10.0,
                      shadowColor: gradientFirst,
                      borderRadius:  BorderRadius.circular(10.0),
                      child: TextFormField(
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(
                          color: gradientSecond,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: gradientThird,
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: gradientFirst)
                          ) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Numéro de téléphone',
                          hintStyle: GoogleFonts.poppins(
                              color: gradientSecond,
                              fontSize: 10.0,
                              //fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: gradientSecond,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: FittedBox(
                      child: GoogleFontOne(
                          size: 10.0,
                          textValue: 'Confirmer',
                        ),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
