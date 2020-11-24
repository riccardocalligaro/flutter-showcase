import 'package:bubble/bubble.dart';
import 'package:chat_client/bloc/chat_bloc.dart';
import 'package:chat_client/models/message_remote_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatBloc _chatBloc;

  // The controllers for the text fields
  TextEditingController _hostEditingController;
  TextEditingController _portEditingController;
  TextEditingController _chatTextEditingController;

  @override
  void initState() {
    super.initState();

    // bloc that we use as a chat and socket manager
    _chatBloc = BlocProvider.of<ChatBloc>(context);

    _hostEditingController = TextEditingController(text: '127.0.01');
    _portEditingController = TextEditingController(text: '8000');
    _chatTextEditingController = TextEditingController(text: '');

    _chatTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TCP Chat'),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (BuildContext context, ChatState chatState) {
          if (chatState.connectionState == SocketConnectionState.Connected) {
            Scaffold.of(context)..hideCurrentSnackBar();
          } else if (chatState.connectionState ==
              SocketConnectionState.Failed) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Connection failed"),
                      Icon(Icons.error),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        builder: (context, chatState) {
          if (chatState.connectionState == SocketConnectionState.None ||
              chatState.connectionState == SocketConnectionState.Failed) {
            return _buildInitial();
          } else if (chatState.connectionState ==
              SocketConnectionState.Connecting) {
            return _buildConnecting();
          } else if (chatState.connectionState ==
              SocketConnectionState.Connected) {
            return _buildConnected(chatState);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildInitial() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: ListView(
        children: [
          TextFormField(
            controller: _hostEditingController,
            decoration: InputDecoration(
              hintText: 'Enter the address here, e. g. 10.0.2.2',
            ),
          ),
          TextFormField(
            controller: _portEditingController,
            decoration: InputDecoration(
              hintText: 'Enter the port here, e. g. 8000',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          RaisedButton(
            child: Text('Connect'),
            onPressed: () {
              _chatBloc.add(
                Connect(
                  host: _hostEditingController.text,
                  port: int.parse(_portEditingController.text),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildConnecting() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 16,
          ),
          Text('Connecting...'),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
            child: Text('Abort'),
            onPressed: () {
              _chatBloc.add(Disconnect());
            },
          )
        ],
      ),
    );
  }

  Widget _buildConnected(ChatState chatState) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: chatState.messages.length,
              itemBuilder: (context, idx) {
                MessageRemoteModel message = chatState.messages[idx];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      message.sender == Sender.Client ? 16.0 : 0,
                      16.0,
                      message.sender == Sender.Server ? 16.0 : 0,
                      0.0),
                  child: Bubble(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(message.message),
                    ),
                    alignment: message.sender == Sender.Client
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: 'Message'),
                  controller: _chatTextEditingController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_chatTextEditingController.text.isNotEmpty) {
                    _chatBloc.add(
                      SendMessage(
                        body: _chatTextEditingController.text,
                      ),
                    );
                    _chatTextEditingController.text = '';
                  }
                },
              )
            ],
          ),
        ),
        SafeArea(
          child: RaisedButton(
            child: Text('Disconnect'),
            onPressed: () {
              _chatBloc.add(Disconnect());
            },
          ),
        ),
      ],
    );
  }
}
