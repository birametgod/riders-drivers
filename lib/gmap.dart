import 'dart:collection';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  bool _showMapStyle = false;

  GoogleMapController _mapController;

  Set<Marker> _markers = HashSet<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(14.499454, -14.445561),
          infoWindow: InfoWindow(
            title: "Dakar",
            snippet: "An Interesting city",
          ),
          //icon: _markerIcon
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  void _toggleMapStyle() async {
    String style =
        await DefaultAssetBundle.of(context).loadString('assets/map.json');

    if (_showMapStyle) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(14.499454, -14.445561),
              zoom: 1,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          GestureDetector(
            child: Container(
                margin: EdgeInsets.only(top: 100),
                child: CustomSwitchButton(backgroundColor: Colors.grey, checked: isChecked, checkedColor: Colors.lightGreen, unCheckedColor: Colors.white,  animationDuration: Duration(milliseconds: 400))),
            onTap: () {
              setState(() {
                _showMapStyle = !_showMapStyle;
              });

              _toggleMapStyle();
            },
          ),
        ],
      ),
    );
  }
}
