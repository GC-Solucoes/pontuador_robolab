// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class BecosWidget extends StatefulWidget {
  const BecosWidget({Key? key}) : super(key: key);

  @override
  _BecosWidgetState createState() => _BecosWidgetState();
}

class _BecosWidgetState extends State<BecosWidget> {
  List<bool> buttonStates = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.width / 8;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(6, (index) {
              final buttonText = (index + 1).toString();
              return InkWell(
                onTap: () {
                  setState(() {
                    buttonStates[index] = !buttonStates[index];
                    if (buttonStates[index]) {
                      SharedAtom.pontos8 += 10;
                    } else {
                      SharedAtom.pontos8 -= 10;
                    }
                  });
                },
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    color: buttonStates[index] ? Colors.green : Colors.green,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: buttonStates[index] ? Colors.white : Colors.black,
                        fontSize: buttonSize / 3,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Pontos: ${SharedAtom.pontos8}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
