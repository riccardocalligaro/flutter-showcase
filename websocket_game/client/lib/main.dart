import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:websocket_game/presentation/start/start_page.dart';

void main() {
  runApp(WebsocketGame());
}

class WebsocketGame extends StatelessWidget {
  const WebsocketGame({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Websocket Game',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: Color(0xffE0E5EC),
      ),
      home: StartPage(),
    );
  }
}
