import 'package:flutter/material.dart';

class TimerDisplayWidget extends StatelessWidget {
  final Duration timeElapsed;

  const TimerDisplayWidget(this.timeElapsed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(timeElapsed),
      style: const TextStyle(fontSize: 48, color: Colors.white),
    );
  }

  String _formatTime(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds =
        (duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds:$milliseconds';
  }
}
