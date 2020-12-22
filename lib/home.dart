import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ridersdrivers_app/gmap.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GMap(),
      ],
    );
  }
}

/*TextField(
cursorColor: Colors.black,
keyboardType: TextInputType.text,
textInputAction: TextInputAction.go,
decoration: InputDecoration(
border: InputBorder.none,
contentPadding:
EdgeInsets.symmetric(horizontal: 20),
hintText: "Where to?"),
),

AddressSearchBox(
                    controller: TextEditingController(),
                    country : "Senegal",
                    hintText: "Where To?",
                    noResultsText: "no result",
                    onDone: (BuildContext dialogContext, AddressPoint point) {
                      bool found = point.found;
                      String address = point.address;
                      String country = point.country;
                      double latitude = point.latitude;
                      double longitude = point.longitude;
                      Navigator.of(dialogContext).pop(); // Use it JUST in a AddressSearchField widget to close the dialog.
                    },
                    onCleaned: () {},
                  )
*/