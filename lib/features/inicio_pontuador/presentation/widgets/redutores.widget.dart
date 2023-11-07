import 'package:flutter/material.dart';

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
    final buttonSize = size.width / 8;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    if (buttonStates[index]) {
                      pontos += 5;
                    } else {
                      pontos -= 5;
                    }
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
              return InkWell(
                onTap: () {
                  setState(() {
                    int buttonIndex = index + 9;
                    buttonStates[buttonIndex] = !buttonStates[buttonIndex];
                    if (buttonStates[buttonIndex]) {
                      pontos += 5;
                    } else {
                      pontos -= 5;
                    }
                  });
                },
                child: buildButton(index + 9, buttonText, buttonSize),
              );
            }),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 15; i < 16; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      buttonStates[i] = !buttonStates[i];
                      if (buttonStates[i]) {
                        pontos += 5;
                      } else {
                        pontos -= 5;
                      }
                    });
                  },
                  child: buildButton(i, (i + 1).toString(), buttonSize),
                ),
            ],
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
            if (buttonStates[index]) {
              pontos += 5;
            } else {
              pontos -= 5;
            }
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
