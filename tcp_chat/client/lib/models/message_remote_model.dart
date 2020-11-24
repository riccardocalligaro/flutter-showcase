import 'package:flutter/foundation.dart';

enum Sender { Client, Server }

class MessageRemoteModel {
  final DateTime timestamp;
  final String message;
  final Sender sender;

  const MessageRemoteModel({
    @required this.timestamp,
    @required this.message,
    @required this.sender,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MessageRemoteModel &&
        o.timestamp == timestamp &&
        o.message == message &&
        o.sender == sender;
  }

  @override
  int get hashCode => timestamp.hashCode ^ message.hashCode ^ sender.hashCode;

  @override
  String toString() =>
      'MessageRemoteModel(timestamp: $timestamp, message: $message, sender: $sender)';
}
