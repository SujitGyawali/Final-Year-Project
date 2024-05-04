import 'package:farmi_culture/education.dart';
import 'package:farmi_culture/home.dart';
import 'package:flutter/material.dart';
import 'aboutus.dart'; // Import the AboutUsPage widget from aboutus.dart
import 'contactus.dart'; // Import the ContactUsPage widget from contactus.dart

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F8E7),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the children horizontally
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF598C00), // Set the container color
                borderRadius: BorderRadius.circular(20.0), // Set the border radius
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'Support Page',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
            const SizedBox(height: 30.0), // Add space above the text
            Container(
              alignment: Alignment.center, // Center the text horizontally and vertically
               // Add horizontal padding
              child: const Text(
                'How the App Works:',
                style: TextStyle(
                  fontSize: 24.0, // Set the font size to 24
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5A6B), // Set the text color
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: const <Widget>[
                  ListTile(
                    title: Text('1. First the app lands on the page where the user can click on “Get Started” button.',),
                  ),
                  ListTile(
                    title: Text('2. If the IoT device is connected main page will open while it will land on the Error Page.'),
                  ),
                  ListTile(
                    title: Text('3. Then the app can be navigated through the bottom bar.'),
                  ),
                  ListTile(
                    title: Text('4. There is the ‘Feedback Form’ page where users can fill the form and submit.'),
                  ),
                  ListTile(
                    title: Text('5. There is the Educational Resource page where the user will get the idea about the project, they will be able to see the YouTube Videos for the idea and also get sample articles for the project reference.'),
                  ),
                  ListTile(
                    title: Text('6. The About Us page is the page where the information about the project listed with the Project initiator Name and Details.'),
                  ),

                  // Add more list tiles for additional steps
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF598C00), // Setting the navigation bar color
        selectedItemColor: Colors.white, // Color for selected items
        unselectedItemColor: Colors.white, // Color for unselected items
        type: BottomNavigationBarType.fixed, // Ensuring all items are shown
        currentIndex: 0, // Set the current index
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsPage()),
            );
          }
          else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EducationalResourcePage()),
            );
          }
          // Handle navigation for other items if needed
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
        ],
      ),
    );
  }
}
