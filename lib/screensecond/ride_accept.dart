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

  Widget riderInfo(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orangeAccent,
      ),
      child: Row(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('rider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.star_border_outlined, color: Colors.lightGreenAccent, size: 22.0,),
                  SizedBox(width: 10,),
                  Text('5.0', style: TextStyle(color: Colors.lightGreenAccent),)
                ],
              )
            ],
          ),
          SizedBox(width: 160,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Icon(Icons.call, color: Colors.black, size: 32.0,),
              SizedBox(width: 5,),
              Text('more info', style: TextStyle(fontWeight: FontWeight.bold),)
              //add call function
            ],
          ),
        ],
      ),
    );
  }

  void showBottomsheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState ) {
                return Container(
                  height: MediaQuery.of(context).size.height  * 0.4,
                  child: Column(
                    children: [
                      SizedBox(height: 30.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
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
                            //margin: const EdgeInsets.all(30.0),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text('DISTANCE', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('_Distance KM')
                              ],
                            ),
                          ),
                          SizedBox(width: 50.0,),
                          Container(
                            width: 150,
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
                            //margin: const EdgeInsets.all(30.0),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text('PRICE', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('_price FCFA')
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      riderInfo(),
                      //TO-DO: change above with driver's information
                      SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Dismiss'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onPrimary: Colors.black,
                              elevation: 4.0,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.white)
                              ),
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                            onPressed: () {
                              //_payement();

                            },
                          ),
                          SizedBox(width: 70.0,),
                          ElevatedButton(
                            child: Row(
                              children: [
                                Text('Accept'),
                                SizedBox(width: 20,),
                                Icon(Icons.directions, size: 30,)
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.brown,
                              onPrimary: Colors.white,
                              elevation: 4.0,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.white)
                              ),
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                            onPressed: () {
                              //_deleteRide();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness:Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.list_outlined, color: Colors.black, size: 32.0,),
            onPressed: (){
              setState(() {
                showBottomsheet(context);
              });
            },
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
                            Text('MOMO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 5),
                            Text('Starter', style: TextStyle(fontSize: 15),)
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

//retrieve connected driver info from firebase by id
//make a realtime listener from Ride collections for checking if there is a new ride request near the driver
//send a notification with a timer 30s to accept
//if he accept give him itinary to get to the rider
