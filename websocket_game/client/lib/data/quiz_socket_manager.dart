import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:websocket_game/data/model/message_remote_model.dart';
import 'package:websocket_game/data/model/player_remote_model.dart';
import 'package:websocket_game/data/model/question_remote_model.dart';

class QuizSocketManager {
  /// The idenitfier, entered with the enterGame method
  String username;

  IO.Socket socket;

  void connect() {
    final url =
        Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';

    // set the ngrok url
    // final url = 'http://d1b4af41b5c8.eu.ngrok.io';

    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  /// Callback when connection to the socket is successfull
  void onConnect(VoidCallback onConnect) {
    return socket.on('connect', (data) => onConnect());
  }

  void enterGame({
    @required String username,
  }) {
    this.username = username;
    return socket.emit('userNew', username);
  }

  /// Call back when a question is recieved
  void onQuestion(ValueChanged<QuestionRemoteModel> onQuestion) {
    return socket.on(
      'question',
      (data) => onQuestion(QuestionRemoteModel.fromJson(json.decode(data))),
    );
  }

  /// Call back when a question is recieved
  void onCurrentPlayers(
      ValueChanged<List<PlayerRemoteModel>> onCurrentPlayers) {
    return socket.on(
      'currentPlayers',
      (data) {
        final Map<String, dynamic> decoded = json.decode(data);

        final players =
            decoded.values.map((e) => PlayerRemoteModel.fromJson(e)).toList();

        onCurrentPlayers(players);
      },
    );
  }

  /// Call back when a question is recieved
  void answerQuestion(int score) {
    socket.emit('userAnswered',
        json.encode({'nickname': this.username, 'score': score}));
  }

  /// Call back when new message is recieved
  void onNewMessage(ValueChanged<MessageRemoteModel> onNewMessage) {
    return socket.on(
      'newMessage',
      (data) {
        print('Got new message');

        final Map<String, dynamic> decoded = json.decode(data);

        final message = MessageRemoteModel.fromJson(decoded);

        onNewMessage(message);
      },
    );
  }

  /// Send a message to the global chat
  void sendMessage(String message) {
    socket.emit(
      'sendMessage',
      json.encode(
        {
          'nickname': this.username,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'content': message,
        },
      ),
    );
  }

  /// Disconnect the connection to the socket
  void disconnect() {
    socket.disconnect();
  }
}
