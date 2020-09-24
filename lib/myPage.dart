import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'dart:collection';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  SpeedDialController _controller = SpeedDialController();

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

  void _currentLocation() async {
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(14.499454, -14.445561),
                  zoom: 1,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFloatingActionButton() {
    final TextStyle customStyle = TextStyle(
      inherit: false,
      color: Colors.black,
    );
    final icons = [
      SpeedDialAction(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF171938),
          child: Icon(
            Icons.help,
            color: Color(0xFF171938),
          ),
          label: Text('Help', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF171938),
          child: Icon(
            Icons.settings_applications,
            color: Color(0xFF171938),
          ),
          label: Text('Settings', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF171938),
          child: Icon(
            Icons.account_balance_wallet,
            color: Color(0xFF171938),
          ),
          label: Text('Payment', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF171938),
          child: Icon(
            Icons.directions_car,
            color: Color(0xFF171938),
          ),
          label: Text('Your Trips', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF171938),
          child: Icon(
            Icons.perm_identity,
            color: Color(0xFF171938),
          ),
          label: Text('Profile', style: customStyle)),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Icon(Icons.view_list, key: UniqueKey()),
      screenColor: Colors.black.withOpacity(0.3),
      //childOnUnfold: Icon(Icons.add),
      useRotateAnimation: false,
      onAction: _onSpeedDialAction,
      controller: _controller,
      isDismissible: true,
      backgroundColor: Color(0xFF880e4f),
      foregroundColor: Color(0xFF171938),
    );
  }

  _onSpeedDialAction(int selectedActionIndex) {
    print('$selectedActionIndex Selected');
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Color(0xFF171938),
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                _currentLocation();
              },
            ),
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: () {
                setState(() {
                  _showMapStyle = !_showMapStyle;
                });

                _toggleMapStyle();
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: Color(0xFF171938),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            RaisedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
