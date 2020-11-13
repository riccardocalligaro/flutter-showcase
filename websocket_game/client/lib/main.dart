import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/manager.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 64,
            ),
            RaisedButton(
              child: Text('Disconnect'),
              onPressed: () {
                socket.disconnect();
              },
            ),
            RaisedButton(
              child: Text('Send message'),
              onPressed: () {
                Map values = {'user': 'user1', 'content': 'Per me no!'};
                socket.emit('sendMessage', json.encode(values));
              },
            ),
            RaisedButton(
              child: Text('Connect to websocket'),
              onPressed: () async {
                socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
                  'transports': ['websocket'],
                  'autoConnect': false,
                });
                socket.connect();

                socket.on('newMessage', (data) {
                  print('Got message');
                  print(data);
                });

                // socket.on('initPlayId', (data) {
                //   print('Got data');
                //   print(data);
                // });

                // socket.on('question', (data) {
                //   print('Got question');
                //   print(data);
                // });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
