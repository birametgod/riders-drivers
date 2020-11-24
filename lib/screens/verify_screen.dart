import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ridersdrivers_app/constants.dart';
import 'package:ridersdrivers_app/widgets/google_font_one.dart';
import 'package:ridersdrivers_app/widgets/text_fitted_box.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gradientFirst,
        elevation: 0,
        leading:  IconButton(
          icon:  Icon(
              Icons.arrow_back,
              size: 20.0,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        decoration: homeBodyDecoration,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: TextFittedBox(
                          text: GoogleFontOne(
                            size: 20.0,
                            textValue: "Enter verification code",
                            //spacing: 1.0,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: TextFittedBox(
                          text: GoogleFontOne(
                            size: 12.0,
                            textValue: " A code has been sent to +33752516199 via sms ",
                            spacing: 1.0,
                            weight: FontWeight.w500,
                            height: 2.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      PinCodeTextField(
                          animationType: AnimationType.fade,
                          backgroundColor: Colors.transparent,
                          keyboardType: TextInputType.number,
                          enableActiveFill: true,
                          obscureText: true,
                          appContext: context,
                          length: 6,
                          textStyle: TextStyle(
                            color: gradientFourth
                          ),
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5.0),
                              inactiveFillColor: gradientZero,
                              inactiveColor: gradientZero,
                              selectedFillColor: gradientZero,
                              selectedColor: gradientThird,
                              activeFillColor: gradientZero,
                              activeColor: gradientZero,
                              borderWidth: 1.0
                          ),
                          onChanged: null
                      ),
                    ],
                  ),
                ),
                Container(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
