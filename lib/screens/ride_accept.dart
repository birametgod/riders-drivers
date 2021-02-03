import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class RideAccept extends StatefulWidget {
  @override
  _RideAcceptState createState() => _RideAcceptState();
}

class _RideAcceptState extends State<RideAccept> with SingleTickerProviderStateMixin {

  GoogleMapController _mapController;
  String mapStyle;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(0.0,0.0));


  AnimationController _animationController;
  Animation _animation;


// For storing the current position
  Position _currentPosition;


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
  void dispose(){
    super.dispose();
  }

  // Method for retrieving the current location
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

  Future<Uint8List> getMarker1() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/person.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  bool isChecked = false;
  String statut = 'Offline';
  String desc = 'Go online to start accepting jobs';



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness:Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.list_outlined, color: Colors.black, size: 32.0,),
            onPressed: (){},
          ) ,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isChecked = !isChecked) {
                    statut = 'Online';
                    desc = 'You can start accepting jobs';
                  }else{
                    statut = 'Offline';
                    desc = 'Go online to start accepting jobs';
                  }
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSwitchButton(
                    backgroundColor: Colors.blueGrey,
                    unCheckedColor: Colors.orangeAccent,
                    animationDuration: Duration(milliseconds: 400),
                    checkedColor: Colors.lightGreen,
                    checked: isChecked,
                  ),
                  Text(statut,
                    style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),)
                ],
              ),
            )
          ],
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
            Positioned(
              top: 1,
              right: 1,
              left: 1,
              child: Container(
                padding: EdgeInsets.all(5),
                height: 45,
                color: Colors.orangeAccent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.car_repair),
                    SizedBox(width: 50,),
                    Center(
                      child: Column(
                        children: [
                          Text('You are $statut', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('$desc')
                        ],
                      ),
                    )
                  ],
                ),
              ),),
            Positioned(
              bottom: 40,
              left: 10,
              right: 10,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown,
                      offset: Offset(2.0, 3.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text('Surnom', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 5),
                            Text('Level', style: TextStyle(fontSize: 15),)
                          ],
                        ),
                        SizedBox(width: 150,),
                        Column(
                          children: [
                            Text('328€', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 5),
                            Text('Earned', style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orangeAccent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.access_time, color: Colors.grey,),
                                  Text('10.2',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  Text('Hours Online', style: TextStyle(color: Colors.grey),)
                                ],
                              ),
                              SizedBox(width: 30,),
                              Column(
                                children: [
                                  Icon(Icons.add_road, color: Colors.grey,),
                                  Text('30',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  Text('Total Distance', style: TextStyle(color: Colors.grey),)
                                ],
                              ),
                              SizedBox(width: 30,),
                              Column(
                                children: [
                                  Icon(Icons.calendar_today, color: Colors.grey,),
                                  Text('20',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  Text('Total Job', style: TextStyle(color: Colors.grey),)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
