import 'dart:async';

import 'package:dartz/dartz.dart' show Tuple2;
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

GlobalKey<TimerWidgetState> timerWidgetKey = GlobalKey();

class TimerWidget extends StatefulWidget {
  /// Callback called when `timeLeft=0`
  final VoidCallback onDone;

  TimerWidget({
    Key key,
    this.onDone,
  }) : super(key: key);

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  /// Time left for the timer to count
  Duration timeLeft;

  // the streams for the timer
  Stream<DateTime> initStream;
  Stream<DateTime> timeStream;

  StreamSubscription<DateTime> timeStreamSubscription;

  // Tens digit and ones digit, decine e unità
  Tuple2 _minutesValues;
  Tuple2 _secondsValues;

  @override
  void initState() {
    super.initState();
  }

  void _setupTimerStreams() {
    var time = DateTime.now();

    // since we can't use Timer.periodic() we use Stream.periodic(), this is the tick stream
    initStream = Stream<DateTime>.periodic(Duration(milliseconds: 1004), (_) {
      // we subtract one second every 'tick'
      timeLeft -= Duration(seconds: 1);
      // if there is no time left, we want to wait the last second
      // and then call on done
      if (timeLeft.inSeconds == 0) {
        Future.delayed(Duration(milliseconds: 1000), () {
          if (widget.onDone != null) {
            timeStreamSubscription.cancel();
            // reset all the values

            setState(() {
              initStream = null;
              _minutesValues = null;
              _secondsValues = null;
            });
            widget.onDone();
          }
        });
      }

      return time;
    });

    // assign the init stream to the timer stream
    timeStream = initStream.take(timeLeft.inSeconds);

    timeStreamSubscription = timeStream.listen((event) {
      setValuesOnTick();
    });
  }

  void setValuesOnTick() {
    // seconds digit
    final tensSecondsDigit = (timeLeft.inSeconds % 60) ~/ 10;
    final onesSecondsDigit = (timeLeft.inSeconds % 60) % 10;

    // minutes digit
    final tensMinutesDigit = (timeLeft.inMinutes % 60) ~/ 10;
    final onesMinutesDigit = (timeLeft.inMinutes % 60) % 10;

    setState(() {
      _secondsValues = Tuple2(tensSecondsDigit, onesSecondsDigit);
      _minutesValues = Tuple2(tensMinutesDigit, onesMinutesDigit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: timerWidgetKey,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildDigits(),
      ),
    );
  }

  List<Widget> _buildDigits() {
    if (_minutesValues == null || _secondsValues == null) {
      return [
        Text(
          'Tap to start',
          style: digitStyle,
        ),
      ];
    }
    return [
      _buildDigit(
        values: _minutesValues,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          ":",
          style: digitStyle,
        ),
      ),
      _buildDigit(
        values: _secondsValues,
      )
    ];
  }

  Widget _buildDigit({
    @required Tuple2 values,
  }) {
    return Text(
      '${values.value1}${values.value2}',
      style: digitStyle,
    );
  }

  void resetTimer() {
    timeStreamSubscription.cancel();
    // reset all the values

    setState(() {
      initStream = null;
      _minutesValues = null;
      _secondsValues = null;
    });
  }

  /// If the timer subscription is `paused` then it
  /// resumes it
  void resumeTimer() async {
    if (initStream == null) {
      // show the picker
      Duration resultingDuration = await showDurationPicker(
        context: context,
        initialTime: Duration(minutes: 5),
      );

      if (resultingDuration != null) {
        setState(() {
          timeLeft = Duration(seconds: resultingDuration.inSeconds);
        });

        // set up the streams
        _setupTimerStreams();

        // set the initial values
        setValuesOnTick();
      }
    } else if (timeStreamSubscription.isPaused) {
      timeStreamSubscription.resume();
    }
  }

  /// Request that the stream pauses events until further notice.
  /// It can be unpaused by calling `resume()`
  Future<void> pauseTimer() async {
    if (!timeStreamSubscription.isPaused) {
      return timeStreamSubscription.pause();
    }
  }

  TextStyle get digitStyle {
    return TextStyle(
      color: Colors.white,
      fontSize: 52,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  void dispose() {
    timeStreamSubscription.cancel();
    super.dispose();
  }
}

class DurationInvalidData implements Exception {
  String cause;
  DurationInvalidData(this.cause);
}
