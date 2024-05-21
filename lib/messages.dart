import 'package:flutter/material.dart';

//Stateful widget that takes a list of messages as a required parameter.
class MessagesScreen extends StatefulWidget {
  //messages is a list of message objects passed to the widget.
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);
  @override
  //_MessagesScreenState is the state class for MessagesScreen
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    //Retrieves the width of device screen for setting constraints on the message container width.
    var w = MediaQuery.of(context).size.width;

    //Creates a ListView that separates each item with a custom separator.
    return ListView.separated(
      //itemBuilder defines how each item is built.
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Color(0xFF598C00)
                            : Color(0xFF598C00)),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child:
                    Text(widget.messages[index]['message'].text.text[0],style: TextStyle(color: Colors.white),)),
              ],
            ),
          );
        },
        //separatorBuilder adds a separator:padding of 10 pixels between each item.
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        //itemCount: Specifies the number of items in the list.
        itemCount: widget.messages.length);
  }
}