import 'package:flutter/material.dart';

class TimerDisplayWidget extends StatelessWidget {
  final Duration timeElapsed;
  final double verticalPadding;
  final double rightPadding;

  const TimerDisplayWidget(this.timeElapsed,
      {Key? key, this.verticalPadding = 0.0, this.rightPadding = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, verticalPadding, rightPadding, 0.0),
      child: Text(
        TimerFormatter.formatTime(timeElapsed),
        style: const TextStyle(fontSize: 19, color: Colors.white),
      ),
    );
  }
}

class TimerFormatter {
  static String formatTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;

    String minutesStr = _twoDigits(minutes);
    String secondsStr = _twoDigits(seconds);
    String millisecondsStr = _twoDigits(milliseconds ~/ 10);

    return '$minutesStr:$secondsStr:$millisecondsStr';
  }

  static String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}
