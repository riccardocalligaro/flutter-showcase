import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_client/models/message_remote_model.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  Socket _socket;
  StreamSubscription _socketStreamSubscription;
  ConnectionTask<Socket> _socketConnectionTask;

  ChatBloc() : super(ChatState.initial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is Connect) {
      yield* _mapConnectEventToState(event);
    } else if (event is Disconnect) {
      yield* _mapDisconnectEventToState();
    } else if (event is ErrorOccured) {
      yield* _mapErrorEventToState();
    } else if (event is MessageReceived) {
      yield state.copyWithNewMessage(message: event.message);
    } else if (event is SendMessage) {
      yield* _mapSendMessageToState(event);
    }
  }

  Stream<ChatState> _mapConnectEventToState(Connect event) async* {
    yield state.copywith(connectionState: SocketConnectionState.Connecting);
    try {
      _socketConnectionTask = await Socket.startConnect(event.host, event.port);
      _socket = await _socketConnectionTask.socket;

      _socketStreamSubscription = _socket.asBroadcastStream().listen((event) {
        this.add(
          MessageReceived(
            message: MessageRemoteModel(
              message: String.fromCharCodes(event),
              timestamp: DateTime.now(),
              sender: Sender.Server,
            ),
          ),
        );
      });
      _socket.handleError(() {
        this.add(ErrorOccured());
      });

      yield state.copywith(connectionState: SocketConnectionState.Connected);
    } catch (err) {
      yield state.copywith(connectionState: SocketConnectionState.Failed);
    }
  }

  Stream<ChatState> _mapDisconnectEventToState() async* {
    yield state.copywith(connectionState: SocketConnectionState.Disconnecting);
    _socketConnectionTask?.cancel();
    await _socketStreamSubscription?.cancel();
    await _socket?.close();
    yield state
        .copywith(connectionState: SocketConnectionState.None, messages: []);
  }

  Stream<ChatState> _mapErrorEventToState() async* {
    yield state.copywith(connectionState: SocketConnectionState.Failed);
    await _socketStreamSubscription?.cancel();
    await _socket?.close();
  }

  Stream<ChatState> _mapSendMessageToState(SendMessage event) async* {
    if (_socket != null) {
      yield state.copyWithNewMessage(
        message: MessageRemoteModel(
          message: event.body,
          timestamp: DateTime.now(),
          sender: Sender.Client,
        ),
      );
      _socket.writeln(event.body);
    }
  }

  @override
  Future<void> close() {
    _socketStreamSubscription?.cancel();
    _socket?.close();
    return super.close();
  }
}
