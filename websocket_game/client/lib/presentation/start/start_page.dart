import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:websocket_game/data/quiz_socket_manager.dart';
import 'package:websocket_game/presentation/navigator_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NICKNAME',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32,
                ),
                Neumorphic(
                  child: TextField(
                    controller: _nameController,
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
                SizedBox(
                  height: 32,
                ),
                _bumpButton(
                  Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),
        ],
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
          if (_nameController.text.isNotEmpty) {
            final quizSocketManager = QuizSocketManager();
            quizSocketManager.connect();
            // enter the game on the servrer
            quizSocketManager.enterGame(username: _nameController.text);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return NavigatorPage(
                  quizSocketManager: quizSocketManager,
                );
              }),
            );
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
