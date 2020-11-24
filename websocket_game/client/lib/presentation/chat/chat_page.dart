import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:websocket_game/data/model/message_remote_model.dart';
import 'package:websocket_game/data/quiz_socket_manager.dart';

class ChatPage extends StatefulWidget {
  final QuizSocketManager quizSocketManager;

  const ChatPage({
    Key key,
    @required this.quizSocketManager,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<MessageRemoteModel> _messages = [];

  @override
  void initState() {
    super.initState();

    widget.quizSocketManager.onNewMessage((message) {
      print('Got new message $message');
      setState(() => _messages.add(message));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                final isCurrentUser =
                    message.nickname == widget.quizSocketManager.username;
                return Padding(
                  padding: EdgeInsets.only(
                    left: isCurrentUser
                        ? MediaQuery.of(context).size.width / 3
                        : 0,
                    right: isCurrentUser
                        ? 0
                        : MediaQuery.of(context).size.width / 3,
                    bottom: 8.0,
                    top: 8.0,
                  ),
                  child: Neumorphic(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'me'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(message.content),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Neumorphic(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                _bumpButton(
                  Icon(
                    Icons.send,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _bumpButton(Widget child) {
    return Neumorphic(
      drawSurfaceAboveChild: false,
      style: NeumorphicStyle(
        depth: 16,
        boxShape: NeumorphicBoxShape.circle(),
        intensity: 0.9,
        shape: NeumorphicShape.concave,
      ),
      child: NeumorphicButton(
        onPressed: () {
          if (_messageController.text.isNotEmpty) {
            widget.quizSocketManager.sendMessage(_messageController.text);
            _messageController.clear();
          }
        },
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(14.0),
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          depth: 20,
          shape: NeumorphicShape.convex,
        ),
        child: child,
      ),
    );
  }
}
