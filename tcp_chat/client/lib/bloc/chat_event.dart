part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class Connect extends ChatEvent {
  /// Server address
  final dynamic host;

  /// Server port
  final int port;

  Connect({
    @required this.host,
    @required this.port,
  })  : assert(host != null),
        assert(port != null);
}

class Disconnect extends ChatEvent {}

class ErrorOccured extends ChatEvent {}

class MessageReceived extends ChatEvent {
  final MessageRemoteModel message;

  MessageReceived({@required this.message});
}

class SendMessage extends ChatEvent {
  final String body;

  SendMessage({@required this.body});
}
