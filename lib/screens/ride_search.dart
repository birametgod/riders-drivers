import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridersdrivers_app/secrets.dart';
import '../components/address_search.dart';
import '../place_service.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:selectable_container/selectable_container.dart';

class RideSearch extends StatefulWidget {
  @override
  _RideSearchState createState() => _RideSearchState();
}

class _RideSearchState extends State<RideSearch> with SingleTickerProviderStateMixin {
  GoogleMapController _mapController;
  String mapStyle;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(0.0,0.0));

  final _fromController = TextEditingController();
  final _whereController = TextEditingController();
  LatLng _startPosition;
  LatLng _destinationPosition;
  String _placeDistance;
  String _price;

  final List<PositionItem> _positionItems = <PositionItem>[];

  var _position = '';
  var lat;
  var lng;

  AnimationController _animationController;
  Animation _animation;


// For storing the current position
  Position _currentPosition;

  List<Marker> markers = <Marker>[];
  Map<MarkerId,Marker> markers1 = {};
  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  GoogleMapPolyline _googleMapPolyline =
  new GoogleMapPolyline(apiKey: Secrets.API_KEY);
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  bool _loading = false;
  bool _select1 = false;
  bool _select2 = false;


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
    _fromController.dispose();
    _whereController.dispose();
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

  // Formula for calculating distance between two coordinates
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


  //add polyline
  _getPolylinesWithAddress() async {

    var addresses = await Geocoder.local.findAddressesFromQuery(_fromController.text);
    _startPosition = LatLng(addresses.first.coordinates.latitude,addresses.first.coordinates.longitude);

    var addresses2 = await Geocoder.local.findAddressesFromQuery(_whereController.text);
    _destinationPosition = LatLng(addresses2.first.coordinates.latitude,addresses2.first.coordinates.longitude);

    print(_startPosition);
    print(_destinationPosition);

    _setLoadingMenu(true);

    Uint8List imageData = await getMarker1();
    Marker startMarker = Marker(
      markerId: MarkerId('$_startPosition'),
      position:_startPosition,
      infoWindow: InfoWindow(
        title: 'From',
      ),
      icon: BitmapDescriptor.fromBytes(imageData),);
    Marker endMarker = Marker(
      markerId: MarkerId('$_destinationPosition'),
      position:_destinationPosition,
      infoWindow: InfoWindow(
        title: 'Destination',
      ),
      icon: BitmapDescriptor.fromBytes(imageData),);




    List<LatLng> _coordinates =
    await _googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: _fromController.text,
        destination: _whereController.text,
        mode: RouteMode.driving);

    Uint8List imageD = await getMarker();
    final List<LatLng> driverLocations = [
      LatLng(45.778964, 4.88205),
      LatLng(45.778752, 4.881267),
    ];

    setState(() {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(_startPosition.latitude,_startPosition.longitude),
              zoom: 18.0
          )
      ));
      _polylines.clear();
      markers.add(startMarker);
      markers.add(endMarker);
      for (LatLng markerLocation in driverLocations) {
        markers.add(
          Marker(
            markerId: MarkerId(driverLocations.indexOf(markerLocation).toString()),
            position: markerLocation,
            icon: BitmapDescriptor.fromBytes(imageD),
          ),
        );
      }
    });
    _addPolyline(_coordinates);
    _setLoadingMenu(false);
    double totalDistance = 0.0;
    double price = 0.0;
    for (int i = 0; i < _coordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
          _coordinates[i].latitude,
          _coordinates[i].longitude,
          _coordinates[i + 1].latitude,
          _coordinates[i + 1].longitude
      );
    }
    setState(() {
      _placeDistance = totalDistance.toStringAsFixed(2);
      print('DISTANCE: $_placeDistance km');
      price = totalDistance * 1000;
      _price = price.toStringAsFixed(2);
      print('PRICE: $price XOF');
    });
  }

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  _setLoadingMenu(bool _status) {
    setState(() {
      _loading = _status;
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

  // Default value for toggle
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  _getToggleChild() {
    if (toggle) {
      return Column(
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.brown,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          Text('Merci de patienter...', style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      );
    } else {
      return Text('Toggle TWO');
    }
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height  * 0.4,
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                          Text('$_placeDistance KM')
                        ],
                      ),
                    ),
                    SizedBox(width: 70.0,),
                    Container(
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
                          Text('$_price FCFA')
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                _getToggleChild(),
                //TO-DO: change above with driver's information
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('PAYER'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown,
                        onPrimary: Colors.white,
                        elevation: 4.0,
                        padding: EdgeInsets.all(15),
                        side: BorderSide(style: BorderStyle.solid, width: 4.0, color: Colors.white),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 70.0,),
                    ElevatedButton(
                      child: Text('Annuler'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown,
                        onPrimary: Colors.white,
                        elevation: 4.0,
                        padding: EdgeInsets.all(15),
                        side: BorderSide(style: BorderStyle.solid, width: 4.0, color: Colors.white),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal
                        ),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                )
              ],
            ),
          );
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
            onPressed: (){},
          ) ,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers),
              polylines: Set<Polyline>.of(_polylines.values),
              initialCameraPosition: _initialPosition,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
            Positioned(
              right: 15,
              left: 15,
              child: Container(
                margin: const EdgeInsets.only(top: 40.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFefebe9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown,
                      offset: Offset(10.0, 10.0), //(x,y)
                      blurRadius: 18.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.grey,
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                boxShadow: [BoxShadow(
                                    color: Color.fromARGB(130, 237, 125, 58),
                                    blurRadius: _animation.value,
                                    spreadRadius: _animation.value
                                )]
                            ),
                            child: Icon(Icons.my_location),
                          ),
                          onPressed: () async {
                            await Geolocator.getCurrentPosition().then((Position position) => {
                              _positionItems.add(PositionItem(
                                  PositionItemType.position, _position.toString())),
                              _position = position.toString(),
                              lat = position.latitude,
                              lng = position.longitude
                            });
                            var addresses = await Geocoder.local.findAddressesFromCoordinates(new Coordinates(lat, lng));
                            var first = addresses.first;
                            setState(() {
                              _fromController.text = first.addressLine;
                              _animationController.stop();
                            });
                          },
                        ),
                        Expanded(
                            child: TextField(
                              controller: _fromController,
                              readOnly: true,
                              onTap: () async {
                                final sessionToken = Uuid().v4();
                                final Suggestion result = await showSearch(
                                  context: context,
                                  delegate: AddressSearch(sessionToken),
                                );
                                if(result != null){
                                  setState(() {
                                    _fromController.text = result.description;
                                  });
                                }
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  hintText: "From"),
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.grey,
                          icon: Icon(Icons.edit_location),
                          onPressed: () {},
                        ),
                        Expanded(
                            child: TextField(
                              controller: _whereController,
                              readOnly: true,
                              onTap: () async {
                                final sessionToken = Uuid().v4();
                                final Suggestion result = await showSearch(
                                  context: context,
                                  delegate: AddressSearch(sessionToken),
                                );
                                if(result != null){
                                  setState(() {
                                    _whereController.text = result.description;
                                    _getPolylinesWithAddress();
                                  });
                                }
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  hintText: "Where to?"),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 50,
              child: SelectableContainer(
                unselectedOpacity:1,
                unselectedBackgroundColor: Colors.transparent,
                selectedBackgroundColor: Colors.transparent,
                icon: Icons.thumb_up,
                iconSize: 24,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFefebe9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown,
                        offset: Offset(10.0, 10.0), //(x,y)
                        blurRadius: 18.0,
                      ),
                    ],
                  ),
                  height: 120.0,
                  width: 120.0,
                  child: Center(child: Column(
                    children: [
                      Image.asset('assets/business.png'),
                      Text('Business'),
                    ],
                  )),
                ),
                onPressed: () {
                  setState(() {
                    _select2 = !_select2;
                  });
                },
                selected: _select2,
              ),
            ),
            Positioned(
              bottom: 150,
              left: 50,
              child: SelectableContainer(
                unselectedOpacity:1,
                unselectedBackgroundColor: Colors.transparent,
                selectedBackgroundColor: Colors.transparent,
                icon: Icons.thumb_up,
                iconSize: 24,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFefebe9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown,
                          offset: Offset(10.0, 10.0), //(x,y)
                          blurRadius: 18.0,
                        ),
                      ],
                    ),
                    height: 120.0,
                    width: 120.0,
                    child: Center(child: Column(
                      children: [
                        Image.asset('assets/taxi.png'),
                        Text('Taxis'),
                      ],
                    ))
                ),
                onPressed: () {
                  setState(() {
                    _select1 = !_select1;
                  });
                },
                selected: _select1,
              ),
            ),
            Positioned(
              bottom: 80,
              right: 50,
              left: 50,
              child: ElevatedButton(
                child: Text('request a ride'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
                  onPrimary: Colors.white,
                  elevation: 2.0,
                  side: BorderSide(style: BorderStyle.solid, width: 4.0, color: Colors.white),
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal
                  ),
                ),
                onPressed: () {
                  displayBottomSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//https://www.google.com/search?q=taxi+driver+homepage+flutter&client=firefox-b-d&sxsrf=ALeKk02SBadtIBn35btvSLGIV2eIYHMXMQ:1611175691954&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjGgaiWsavuAhXJ3oUKHeczDnEQ_AUoAXoECAUQAw&biw=1280&bih=703#imgrc=cMcjclmdFGQfTM
//https://code.market/product/flutter-taxi-app-driver-ui-kit/