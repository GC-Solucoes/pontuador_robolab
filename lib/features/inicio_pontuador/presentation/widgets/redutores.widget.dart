// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class RedutoresWidget extends StatefulWidget {
  const RedutoresWidget({Key? key}) : super(key: key);

  @override
  _RedutoresWidgetState createState() => _RedutoresWidgetState();
}

class _RedutoresWidgetState extends State<RedutoresWidget> {
  int pontos = 0;
  List<bool> buttonStates = List.generate(15, (index) => false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = (size.width - 5) / 7.6;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: buttonSize / 4,
            runSpacing: buttonSize / 4,
            children: List.generate(9, (index) {
              final buttonText = (index + 1).toString();
              return InkWell(
                onTap: () {
                  setState(() {
                    buttonStates[index] = !buttonStates[index];
                    updatePoints(index);
                  });
                },
                child: buildButton(index, buttonText, buttonSize),
              );
            }),
          ),
          const SizedBox(height: 10),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: buttonSize / 4,
            runSpacing: buttonSize / 4,
            children: List.generate(6, (index) {
              final buttonText = (index + 10).toString();
              final buttonIndex = index + 9;
              return InkWell(
                onTap: () {
                  setState(() {
                    buttonStates[buttonIndex] = !buttonStates[buttonIndex];
                    updatePoints(buttonIndex);
                  });
                },
                child: buildButton(buttonIndex, buttonText, buttonSize),
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

  void updatePoints(int index) {
    if (index <= 15) {
      pontos += buttonStates[index] ? 5 : -5;
      SharedAtom.pontos4 = pontos; // Adicionar pontuação ao SharedAtom.pontos3
    }
  }

  Widget buildButton(int index, String buttonText, double buttonSize) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: buttonStates[index] ? Colors.green : Colors.green,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            buttonStates[index] = !buttonStates[index];
            updatePoints(index);
          });
        },
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonStates[index] ? Colors.white : Colors.black,
              fontSize: buttonSize / 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
