import 'package:flutter/material.dart';

class RedutoresWidget extends StatefulWidget {
  const RedutoresWidget({Key? key}) : super(key: key);

  @override
  _RedutoresWidgetState createState() => _RedutoresWidgetState();
}

class _RedutoresWidgetState extends State<RedutoresWidget> {
  int pontos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0, // Espaçamento horizontal entre os botões
          runSpacing: 8.0, // Espaçamento vertical entre as linhas de botões
          children: List.generate(15, (index) {
            final buttonText = (index + 1).toString();
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  pontos += 5;
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
