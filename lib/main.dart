import 'package:flutter/material.dart';

void main() {
  runApp(FriendlyChatApp());
}

class FriendlyChatApp extends StatefulWidget {
  @override
  _FriendlyChatAppState createState() => _FriendlyChatAppState();
}

class _FriendlyChatAppState extends State<FriendlyChatApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'FriendlyChatApp', home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  void _handleSubmitted(String text) 
  {
    _textController.clear();
  }
  Widget _buildTextComposer() {
  return IconTheme(
    data: IconThemeData(color: Theme.of(context).accentColor), // NEW
    child:Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child:  Row(                             // NEW
      children: [                            // NEW
         Flexible(                           // NEW
          child:  TextField(
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration:  InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text)), 
          )                                 
        ],                                      // NEW
      ),                                        // NEW
    ));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FriendlyChatApp"),
      ),
      body: _buildTextComposer(),
    );
  }
}
