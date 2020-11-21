import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:websocket_game/presentation/start/start_page.dart';

void main() {
  runApp(WebsocketGame());
}

class WebsocketGame extends StatefulWidget {
  @override
  _WebsocketGameState createState() => _WebsocketGameState();
}

class _WebsocketGameState extends State<WebsocketGame> {
  IO.Socket socket;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Websocket game',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: Color(0xffE0E5EC),
      ),
      home: StartPage(),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
