import 'package:farmi_culture/contactus.dart';
import 'package:farmi_culture/home.dart';
import 'package:flutter/material.dart';
import 'support.dart'; // Import the SupportPage widget from support.dart
import 'aboutus.dart'; // Import the AboutUsPage widget from aboutus.dart
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EducationalResourcePage extends StatelessWidget {
  YoutubePlayerController _ytcontrol = YoutubePlayerController(
      initialVideoId: 'u3bHn12q-Vw',
      flags: YoutubePlayerFlags(autoPlay: false, mute: true)
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F8E7), // Set background color to E4F8E7
      body: Padding(
        padding: EdgeInsets.only(top: 60.0), // Add padding at the top
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'YouTube Link',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5A6B), // Set text color to 4A5A6B
                ),
              ),
              SizedBox(height: 40.0),
              YoutubePlayer(controller: _ytcontrol),
              SizedBox(height: 60.0),
              Text(
                'Articles and Reports',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5A6B), // Set text color to 4A5A6B
                ),
              ),
              SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true, // Add this to prevent the ListView from taking full height
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      articles[index],
                      style: TextStyle(color: Color(0xFF4A5A6B)), // Set text color to 4A5A6B
                    ),
                    onTap: () {
                      // Handle tapping on an article
                    },
                  );
                },
              ),
            ],
          ),
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
          }else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsPage()),
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

// Sample list of articles
List<String> articles = [
  '1. Enhancing Crop Growth Efficiency through IoT Enabled Smart Farming System',
  '2. Design and Implementation of an IoT Based Crop Monitoring System',
  '3. A New Approach for Crop Selection and Water Management',
];
