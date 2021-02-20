import 'package:flutter/material.dart';

//implement info page like uber eat cf screen on phone

class DetailScreen extends StatefulWidget {

  @override
  _DetailScreenState createState() => _DetailScreenState();
  String id;

  DetailScreen({
    this.id,
  });
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness:Brightness.light,
        leading: IconButton(
          icon: Icon(Icons.list_outlined, color: Colors.black, size: 32.0,),
          onPressed: (){},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.id),
            FlatButton(
              child: Text('Pop!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}