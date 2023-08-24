import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/timer_controls_buttons.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/timer_display_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (!_isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
        setState(() {});
      });
      _isRunning = true;
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _isRunning = false;
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pontuador - Robolab'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TimerDisplayWidget(_stopwatch.elapsed),
            const SizedBox(height: 20),
            TimerControlButtons(
              onStart: _startTimer,
              onPause: _pauseTimer,
              onReset: _resetTimer,
            ),
          ],
        ),
      ),
    );
  }
}
