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
  ChatMessage({this.text, this.animationController}); // NEW
  final String text;
  final AnimationController animationController;
  String _name = 'Your Name';
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        // NEW
        sizeFactor: // NEW
            CurvedAnimation(
                parent: animationController, curve: Curves.easeOut), // NEW
        axisAlignment: 0.0, // NEW
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(_name[0])),
              ),
              Expanded(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_name, style: Theme.of(context).textTheme.headline4),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                    ),
                  ],
               )
              ),
            ],
          ),
        ));
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = []; // NEW
  final _textController = TextEditingController();
  bool _isComposing = false; 
  final FocusNode _focusNode = FocusNode();
  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {                             // NEW
    _isComposing = false;                   // NEW
    }); 
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        // NEW
        duration: const Duration(milliseconds: 700), // NEW
        vsync: this, // NEW
      ),
    ); //NEW
    setState(() {
      //NEW
      _messages.insert(0, message); //NEW
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor), // NEW
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            // NEW
            children: [
              // NEW
              Flexible(
                child: TextField(
                  controller: _textController,
                   onChanged: (String text) {            // NEW
                    setState(() {                       // NEW
                      _isComposing = text.length > 0;   // NEW
                    });                                 // NEW
                  }, 
                  onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: 'Send a message'),
                  focusNode: _focusNode,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,)
              )], // NEW
          ), // NEW
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FriendlyChatApp"),
      ),
      body: Column(
        // MODIFIED
        children: [
          // NEW
          Flexible(
            // NEW
            child: ListView.builder(
              // NEW
              padding: EdgeInsets.all(8.0), // NEW
              reverse: true, // NEW
              itemBuilder: (_, int index) => _messages[index], // NEW
              itemCount: _messages.length, // NEW
            ), // NEW
          ), // NEW
          Divider(height: 1.0), // NEW
          Container(
            // NEW
            decoration:
                BoxDecoration(color: Theme.of(context).cardColor), // NEW
            child: _buildTextComposer(), //MODIFIED
          ), // NEW
        ], // NEW
      ),
    );
  }

  void dispose() 
  {  
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
