import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:farmi_culture/aboutus.dart';
import 'package:farmi_culture/contactus.dart';
import 'package:farmi_culture/education.dart';
import 'package:farmi_culture/support.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;  // Importing http package
import 'dart:convert';  // Importing JSON package for encoding/decoding

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  String cropSuggestion = "--";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) {
        // Handle notification tap
      },
    );

    // Request notification permission (if required by some devices)
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  Future<void> _sendNotification(String crop) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'crop_prediction', 'Crop Prediction',
        channelDescription: 'Channel for Crop Prediction Notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Crop Prediction Result',
        'The best crop for the given conditions is $crop',
        platformChannelSpecifics,
      );
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  Future<void> _initializeFirebase() async {
    if (Firebase.apps.isEmpty) { // Ensure Firebase is initialized only once
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyCZtH0dvUzKW4kDoWy3lbh6A_4GIRh2Xj4',
          projectId: 'farmiculture-57e37',
          messagingSenderId: '848876245312',
          appId: '1:848876245312:android:abe3fc818c09ea27006aa5',
          databaseURL: 'https://farmiculture-57e37-default-rtdb.asia-southeast1.firebasedatabase.app',
        ),
      );
    }
  }

// Add a variable to hold the latest sensor data
  Map<String, dynamic> _latestSensorData = {};

// Modify the getSensorDataStream method to capture the latest sensor data
  Stream<Map<String, dynamic>> getSensorDataStream() {
    return _databaseRef
        .child('sensorData')
        .onValue
        .map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      Map<String, dynamic> latestData = {};

      if (data != null) {
        var sortedEntries = data.entries.toList()
          ..sort((a, b) {
            var aTime = DateTime.parse(
                '${DateTime.now().toIso8601String().split("T")[0]}T${a
                    .value["fields"]["timestamp"]}');
            var bTime = DateTime.parse(
                '${DateTime.now().toIso8601String().split("T")[0]}T${b
                    .value["fields"]["timestamp"]}');
            return bTime.compareTo(aTime);
          });

        var newestEntry = sortedEntries.first.value['fields'];

        latestData['temperature'] = newestEntry['temperature'];
        latestData['humidity'] = newestEntry['humidity'];
        latestData['soilMoisture'] = newestEntry['soilMoisture'];
      } else {
        latestData['temperature'] = 'N/A';
        latestData['humidity'] = 'N/A';
        latestData['soilMoisture'] = 'N/A';
      }

      // Update the latest sensor data variable
      _latestSensorData = latestData;

      return latestData;
    });
  }


  // Method to load CSV from assets and update the crop suggestion
  Future<void> _loadCSV(String temperature, String humidity, String soilMoisture) async {
    String apiLink = "192.168.1.71:8000";
    final client = http.Client();
    var result = "";
    // setLoading(true);
    try {
      var url = Uri.http(apiLink, 'predict/');
      // print(id);
      var response = await http.post(url, body: {
        "temperature": temperature,
        "humidity": humidity,
        "soilMoisture": soilMoisture
      });
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // _allData = data["content"];
        // _cat = data['title'];
        // hasLoadedData = true;
        // notifyListeners();
        result = data["category"];
      }
    }
    on SocketException catch (e) {
      // Handle SocketException
      print(e.message);


    } on http.ClientException catch (e) {
      // Handle http.ClientException
      // print("error");


    } finally {
      client.close(); //// Close the client when done
    }

    setState(() {
      cropSuggestion = result; // Display content from CSV label column
    });

    // Send a notification with the crop suggestion
    await _sendNotification(cropSuggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F8E7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFF598C00),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome Users',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'To the IoT Project',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            StreamBuilder<Map<String, dynamic>>(
              stream: getSensorDataStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  var data = snapshot.data;

                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    shrinkWrap: true,
                    children: [
                      _buildInfoCard('Temperature', '${data?['temperature']}°C',
                          Color(0xFF598C00)),
                      _buildInfoCard('Humidity', '${data?['humidity']}',
                          Color(0xFF598C00)),
                      _buildInfoCard(
                          'Soil Moisture', '${data?['soilMoisture']}',
                          Color(0xFF598C00)),
                      _buildButtonCard(
                          'Action', 'Predict \n  Crop', Color(0xFF598C00), ()
                      {
                        _loadCSV(data!['temperature'].toString(), data!['humidity'].toString(),
                            data!['soilMoisture'].toString());
                      })
                      // ElevatedButton(
                      //   onPressed: () {
                      //     final features = [25.0, 60.0, 40.0];  // Example data
                      //     predictCrop(features, updateCropSuggestion);  // Call predictCrop and pass the update function
                      //   },
                      //   child: Text('Predict Crop $cropSuggestion'),
                      // ),
                    ],
                  );
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
            SizedBox(height: 20.0),
            Container(
              height: 130.0,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Best Crop For This Soil Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '$cropSuggestion',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF598C00),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EducationalResourcePage()),
              );
              break;
          }
        },
        items: const [
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
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
        ],
      ),
    );
  }

  Widget _buildButtonCard(String title, String buttonLabel, Color color,
      VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEEEEEE), // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonLabel,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
