import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ridersdrivers_app/widgets/card_info.dart';


class GeolocationScreen extends StatefulWidget {
  @override
  _GeolocationScreenState createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {

  Future <DocumentReference>addUserInside(User user, BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
    //iu.doc(user.uid)
        .add({"name": user.displayName, "email": user.email});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFE7E7E7),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light, // status bar brightness
          title: Text(
            'Activer la géolocalisation',
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
            padding: EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      CardInfo(imagePath: 'assets/images/second_gps.png', width: 150.0, height: 150.0,),
                      Text(
                        'Partagez votre position avec',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Text(
                        'Activez la géolocalisation pour découvrir \n les chauffeurs à proximité',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: Colors.grey[700]
                        ),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(0.0),
                  color: Color(0xFFF2B903),
                  child:  Container(
                    //color:  Color(0xFFF2B903),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                          'Partager ma position',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          )
                      )
                  )
                ),
              ],
            ),
          ),
        )
    );
  }
}
