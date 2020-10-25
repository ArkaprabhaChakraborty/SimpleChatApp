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
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});     // NEW
  final String text;
  String _name = 'Your Name';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text(_name[0])),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_name, style: Theme.of(context).textTheme.headline4),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(text),
          ),
        ],
      ),
    ],
  ),
    );
  }
}
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];      // NEW  
  final _textController = TextEditingController();
  void _handleSubmitted(String text) 
  {
    _textController.clear();
    ChatMessage message = ChatMessage(text: text);                                    //NEW
    setState(() {                         //NEW
      _messages.insert(0, message);       //NEW
    });                                   //NEW
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
