import 'package:farmi_culture/landing.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F8E7), // Set background color to E4F8E7
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/FarmiCulture.png', // Change this to your image path
                  width:250.0,
                  height: 250.0,
                ),
                Image.asset(
                  'assets/warning.webp', // Change this to your error image path
                  width: 200.0,
                  height: 200.0,
                ),
                SizedBox(height: 30.0),
                Text(
                  'SORRY!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'The Device Connection',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'Unsuccessful\n\n',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0), // Add spacing between buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0), // Add padding to the buttons
              child: SizedBox(
                width: double.infinity, // Set width to full width of the screen
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF598C00), // Set button background color to 598C00
                    shape: RoundedRectangleBorder( // Set button shape to rectangle with sharp edges
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0), // Adjust padding to match "Get Started" button
                  ),
                  child: Text(
                    'Try Again',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0), // Add spacing at the bottom
          ],
        ),
      ),
    );
  }
}
