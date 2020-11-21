import 'package:flutter/material.dart';
import 'package:websocket_game/data/quiz_socket_manager.dart';
import 'package:websocket_game/presentation/chat/chat_page.dart';
import 'package:websocket_game/presentation/home/home_page.dart';

class NavigatorPage extends StatefulWidget {
  final QuizSocketManager quizSocketManager;

  const NavigatorPage({
    Key key,
    @required this.quizSocketManager,
  }) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  /// All the differnet pages in the bottom app bar
  List<Widget> _pages;

  int _currentIndex = 0;

  @override
  void initState() {
    _pages = [
      HomePage(
        quizSocketManager: widget.quizSocketManager,
      ),
      ChatPage(
        quizSocketManager: widget.quizSocketManager,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xffe8eaed),
      onTap: (int index) {
        setState(() => _currentIndex = index);
      },
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.chat_bubble),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.quizSocketManager.disconnect();
    super.dispose();
  }
}
