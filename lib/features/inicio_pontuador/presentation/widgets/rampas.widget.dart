// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class RampasWidget extends StatefulWidget {
  const RampasWidget({Key? key}) : super(key: key);

  @override
  _RampasWidgetState createState() => _RampasWidgetState();
}

class _RampasWidgetState extends State<RampasWidget> {
  int pontos = 0;
  List<bool> buttonStates = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(10, (index) {
              final buttonText = (index + 1).toString();
              return InkWell(
                onTap: () {
                  setState(() {
                    buttonStates[index] = !buttonStates[index];
                    if (buttonStates[index]) {
                      pontos += 10;
                    } else {
                      pontos -= 10;
                    }
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: buttonStates[index] ? Colors.grey : Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Pontos: $pontos',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
