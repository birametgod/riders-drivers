import 'package:flutter/material.dart';
import 'ride_search.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: RideSearch(),
  ));
}


//add alert message with notifications https://itnext.io/local-notifications-in-flutter-6136235e1b51
//https://www.freecodecamp.org/news/how-to-add-push-notifications-to-flutter-app/
//https://medium.com/firebase-tips-tricks/how-to-use-cloud-firestore-in-flutter-9ea80593ca40

//https://medium.com/firebase-tips-tricks/how-to-use-firebase-realtime-database-with-flutter-ebd98aba2c91 android firebase config




//https://medium.com/flutter-community/flutter-creating-a-route-calculator-using-google-maps-71699dd96fb9
//https://github.com/sbis04/flutter_maps/tree/master/lib
//ElevatedButton(
//onPressed: () {
//Navigator.pop(context);
//},
//child: Text('Go back!'),
//),
//https://material.io/components/sheets-bottom/flutter#modal-bottom-sheet
