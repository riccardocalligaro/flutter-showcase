part of 'chat_bloc.dart';

enum SocketConnectionState {
  Connecting,
  Disconnecting,
  Connected,
  Failed,
  None
}

@immutable
class ChatState {
  final SocketConnectionState connectionState;
  final List<MessageRemoteModel> messages;

  ChatState({
    @required this.connectionState,
    @required this.messages,
  });

  factory ChatState.initial() {
    return ChatState(
      connectionState: SocketConnectionState.None,
      messages: <MessageRemoteModel>[],
    );
  }

  ChatState copywith({
    SocketConnectionState connectionState,
    List<MessageRemoteModel> messages,
  }) {
    return ChatState(
      connectionState: connectionState ?? this.connectionState,
      messages: messages ?? this.messages,
    );
  }

  ChatState copyWithNewMessage({@required MessageRemoteModel message}) {
    return ChatState(
      connectionState: this.connectionState,
      messages: List.from(this.messages)..add(message),
    );
  }
}
