import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnexionScreen extends StatefulWidget {
  @override
  _ConnexionScreenState createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {

  TextEditingController phoneController;
  FocusNode _phoneFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E7E7) ,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light, // status bar brightness
        title: Text(
          'Inscription ou connexion',
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
            color: Color(0xFFE7E7E7),
           margin: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Abiria",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                        color: Colors.grey[800],
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                      //letterSpacing: spacing,
                      //height: height
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0.0),
                      child:  Container(
                        color: Color(0xFF0596F2),
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/facebo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                                'Continuer avec Facebook',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0.0),
                      child:  Container(
                        color:  Color(0xFFF7F7F7),
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Container(
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/google.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                                'Continuer avec Google',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w300
                                )
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            color: Colors.black,
                            height: 10,
                            thickness: 1,
                            indent: 10,
                            endIndent: 20,
                          )
                      ),
                      Text(
                        "Ou",
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                          child: Divider(
                            color: Colors.black,
                            height: 10,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          )
                      ),
                    ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saisissez votre numéro de téléphone",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0.0),
                      color: Color(0xFFF7F7F7),
                      child:  Container(
                        //color:  Color(0xFFF2B903),
                          padding: EdgeInsets.all(10.0),
                          child: Container(

                            child: Row(
                              children: [
                                CountryCodePicker(
                                  onChanged: print,
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'IT',
                                  favorite: ['+39','FR'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: false,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  // optional. aligns the flag and the Text left
                                  alignLeft: false,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width: 110.0,
                                  child: TextFormField(
                                    controller: phoneController,
                                    focusNode: _phoneFocusNode,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        focusColor: Colors.black,
                                        hoverColor: Colors.black,
                                        hintText: 'saisir numéro',
                                    ),
                                  ),
                                )
                              ],
                            )
                          )
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(0.0),
                  color: Color(0xFFF2B903),
                  child:  Container(
                      //color:  Color(0xFFF2B903),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          'Continuer',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          )
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
