import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

//get ride collections

class RideWait extends StatefulWidget {
  @override
  _RideWaitState createState() => _RideWaitState();
}

class _RideWaitState extends State<RideWait> with SingleTickerProviderStateMixin{
  GoogleMapController _mapController;
  String mapStyle;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(0.0,0.0));


  AnimationController _animationController;
  Animation _animation;


// For storing the current position
  Position _currentPosition;

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_currentPosition.latitude,_currentPosition.longitude),
                zoom: 18.0
            )
        ));
      });
    }).catchError((e) {
      print(e);
    });
  }


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation =  Tween(begin: 2.0,end: 10.0).animate(_animationController)..addListener((){
      setState(() {
        //_getCurrentLocation();
      });
    });
    //Load map style set it as a value of mapStyle
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });

  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _mapController.setMapStyle(mapStyle);
      _getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.list_outlined, color: Colors.black, size: 32.0,),
            onPressed: (){},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),

            //add polygone riders to driver
            //update polygone each 5s
            //add markers others drivers
            //add cancel bottom -> delete ride collection
          ],
        ),
      ),
    );
  }
}
