import 'package:flutter/material.dart';

class GapWidget extends StatefulWidget {
  const GapWidget({Key? key}) : super(key: key);

  @override
  _GapWidgetState createState() => _GapWidgetState();
}

class _GapWidgetState extends State<GapWidget> {
  int pontos = 0;
  List<bool> buttonStates = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    pontos += 15;
                  } else {
                    pontos -= 15;
                  }
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: buttonStates[index] ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
