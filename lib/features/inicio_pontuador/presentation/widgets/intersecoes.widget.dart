// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class IntersecoesWidget extends StatefulWidget {
  const IntersecoesWidget({Key? key}) : super(key: key);

  @override
  _IntersecoesWidgetState createState() => _IntersecoesWidgetState();
}

class _IntersecoesWidgetState extends State<IntersecoesWidget> {
  List<bool> buttonStates = List.generate(16, (index) => false);

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
            spacing: buttonSize / 4,
            runSpacing: buttonSize / 4,
            children: List.generate(16, (index) {
              final buttonText = (index + 1).toString();
              return InkWell(
                onTap: () {
                  setState(() {
                    buttonStates[index] = !buttonStates[index];
                    updatePoints(index);
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
            'Pontos: ${SharedAtom.pontos5}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void updatePoints(int index) {
    if (index < 16) {
      if (buttonStates[index]) {
        SharedAtom.pontos5 += 10;
      } else {
        SharedAtom.pontos5 -= 10;
      }
    }
  }
}
