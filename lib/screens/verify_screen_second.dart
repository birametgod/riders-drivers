import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ridersdrivers_app/constants.dart';

class VerifyScreenSecond extends StatefulWidget {
  @override
  _VerifyScreenSecondState createState() => _VerifyScreenSecondState();
}

class _VerifyScreenSecondState extends State<VerifyScreenSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E7E7),
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light, // status bar brightness
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFF2BB00),
            ),
          ),
          title: Text(
            'Confirmation',
            textAlign: TextAlign.center ,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saisissez le code 4 chiffres reçus',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0,right: 30.0),
                  child: PinCodeTextField(
                      animationType: AnimationType.slide,
                      backgroundColor: Colors.transparent,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      appContext: context,
                      length: 4,
                      keyboardAppearance: Brightness.dark,
                      textStyle: TextStyle(
                          color: Colors.black
                      ),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5.0),
                          inactiveColor: Colors.black,
                          selectedColor: Colors.grey,
                          activeColor: Colors.black,
                          borderWidth: 1.0,
                      ),
                      onChanged: null
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Vous n'avez pas reçu ce code"
                    ),
                    Ink(
                      width: 65.0,
                      decoration:  ShapeDecoration(
                        color: Color(0xFFF2BB00),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0,color: Color(0xFF464F63)),
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF464F63),
                          size: 35.0,
                        ),
                        onPressed: null)
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
