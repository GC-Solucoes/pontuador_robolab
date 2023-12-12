// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class TimerFormatter {
  static String formattedElapsedTime(Duration elapsedTime) {
    int seconds = elapsedTime.inSeconds % 60;
    int minutes = (elapsedTime.inSeconds ~/ 60) % 60;
    int hours = elapsedTime.inHours;

    String secondsStr = seconds.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String hoursStr = hours.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
