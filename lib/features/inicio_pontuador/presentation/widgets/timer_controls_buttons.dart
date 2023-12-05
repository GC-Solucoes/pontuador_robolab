// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TimerControlButtons extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const TimerControlButtons(
      {super.key,
      required this.onStart,
      required this.onPause,
      required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onStart,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: const Text('Iniciar'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: onPause,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: const Text('Pausar'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: onReset,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: const Text('Zerar'),
        ),
      ],
    );
  }
}
