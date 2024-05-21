import 'package:farmi_culture/home.dart';
import 'package:farmi_culture/landing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is fully initialized

  //Checks if any Firebase app instances have already been initialized.
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  runApp(MyApp()); //Runs the app by calling the MyApp widget.
}

//MyApp is a stateless widget that serves as the root of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  //MaterialApp is a widget which wraps several widgets commonly required for a Material Design app.
      home: LandingPage(),  //Sets the LandingPage widget as the home screen of the app.
      debugShowCheckedModeBanner: false,  //Disables the debug banner that appears in the top-right corner of the app during development.
    );
  }
}