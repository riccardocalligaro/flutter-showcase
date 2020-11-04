import 'package:flutter/material.dart';
import 'package:timer/timer/widget/timer_widget.dart';
import 'package:timer/timer/widget/wave_background.dart';

GlobalKey<TimerWidgetState> _timerKey = GlobalKey();

/// Page that containts the timer widget and the background
class TimerPage extends StatefulWidget {
  const TimerPage({Key key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool _paused = true;

  bool _startedFirstTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WaveBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TimerWidget(
                key: _timerKey,
                onDone: () {
                  setState(() {
                    _startedFirstTime = false;
                    _paused = true;
                  });
                },
              ),
              SizedBox(
                height: 32,
              ),
              // the action buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionIconButton(),
                  if (_startedFirstTime && _paused) _buildResetIconButton(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResetIconButton() {
    return MaterialButton(
      onPressed: () {
        if (_paused) {
          _timerKey.currentState.resetTimer();
        }

        setState(() {
          _paused = true;
          _startedFirstTime = false;
        });
      },
      color: Colors.blue[600],
      textColor: Colors.white,
      child: Icon(
        Icons.restore,
        size: 24,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    );
  }

  Widget _buildActionIconButton() {
    final icon = _paused ? Icons.play_arrow : Icons.pause;
    return MaterialButton(
      onPressed: () {
        if (_paused) {
          _timerKey.currentState.resumeTimer();
        } else {
          _timerKey.currentState.pauseTimer();
        }

        setState(() {
          _paused = !_paused;
          _startedFirstTime = true;
        });
      },
      color: Colors.blue[600],
      textColor: Colors.white,
      child: Icon(
        icon,
        size: 24,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    );
  }
}
