import 'package:farmi_culture/home.dart';
import 'package:flutter/material.dart';

//LandingPage is a stateless widget which does not change its state after it is built.
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F8E7), // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(  //Allows for richly formatted text with different styles.
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Grow Your\n',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A5A6B), // Set text color to 4A5A6B
                    ),
                  ),
                  TextSpan(
                    text: 'Crops Well',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A5A6B), // Set text color to 4A5A6B
                    ),
                  ),
                ],
              ),
            ),

            //Adding vertical space between the widgets.
            SizedBox(height: 10.0),
            Text(
              '"Life grows where seeds are sown"',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF4A5A6B), // Set text color to 4A5A6B
              ),
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/FarmiCulture.png', // Change this to your image path
              width: 400.0,
              height: 350.0,
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0), // Add padding to the button
              child: SizedBox(
                width: double.infinity, // Make the button width match the width of the screen
                child: InkWell(   //Makes the button tappable and provides a ripple effect.
                  onTap: () {  //Defines the action when the button is tapped. It navigates to the HomePage.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF598C00),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
