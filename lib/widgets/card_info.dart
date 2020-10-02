import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {

  CardInfo({ @required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(imagePath),
              width: 300.0,
              height: 300.0,
            ),
          )
        ],
      ),
    );
  }
}