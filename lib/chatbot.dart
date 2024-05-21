import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:farmi_culture/home.dart';
import 'package:farmi_culture/support.dart';
import 'package:flutter/material.dart';
import 'contactus.dart';
import 'education.dart';
import 'messages.dart';

//Chatbot is a statefulwidget which maintains state that may change during widget lifecycle
class ChatBot extends StatefulWidget {
  const ChatBot({super.key});
  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;  //instance of DialogFlowtter for interacting with Dialog Flow
  final TextEditingController _controller = TextEditingController();  //Text editing controller for input field
  List<Map<String, dynamic>> messages = []; //List of messages between user and chatbot
  @override
  //Initialize the DialogFlowtter instance from file contaning configuration data
  void initState() {
    DialogFlowtter.fromFile().then((instance)=>dialogFlowtter=instance);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F8E7),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF598C00), // Set the container color
                borderRadius: BorderRadius.circular(20.0), // Set the border radius
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'FarmiCulture ChatBot',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),

            //MessagesScreen to display the list of messages exchanged within the chatbot
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Color(0xFFEEEEEE),
              child: Row(
                children: [
                  Expanded(
                    //Allow user to type the messages
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.black),
                      )),
                  IconButton(
                    //Allows user to send messages to chatbot
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
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
                MaterialPageRoute(builder: (context) => SupportPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EducationalResourcePage()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatBot()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'ChatBot',
          ),
        ],
      ),
    );
  }

 //Sends the user input to Dialogflow and adds both user message and response to the list of messages.
  sendMessage(String text) async {
    //Checks if the message is not empty.
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text],)), true);
      });
      //Sends the message to Dialogflow and awaits the response.
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        //Adds the response message to the state.
        addMessage(response.message!);
      });
    }
  }

  //Adds a message to the list indicating whether it is a user message and color is assigned accordingly.
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message,
      'isUserMessage': isUserMessage,
      'color': isUserMessage ? Colors.white : Colors.green,
    });
  }
}
