import 'package:flutter/material.dart';

class ObstaculosWidget extends StatefulWidget {
  const ObstaculosWidget({Key? key}) : super(key: key);

  @override
  _ObstaculosWidgetState createState() => _ObstaculosWidgetState();
}

class _ObstaculosWidgetState extends State<ObstaculosWidget> {
  int pontos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0, // Espaçamento horizontal entre os botões
          runSpacing: 8.0, // Espaçamento vertical entre as linhas de botões
          children: List.generate(6, (index) {
            final buttonText = (index + 1).toString();
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  pontos += 15;
                });
              },
              child: Text(buttonText),
            );
          }),
        ),
        const SizedBox(height: 10), // Espaço entre os botões e os pontos
        Text(
          'Pontos: $pontos',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
