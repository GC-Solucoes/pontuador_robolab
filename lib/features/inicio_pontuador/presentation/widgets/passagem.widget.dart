import 'package:flutter/material.dart';

class PassagemWidget extends StatefulWidget {
  const PassagemWidget({Key? key}) : super(key: key);

  @override
  _PassagemWidgetState createState() => _PassagemWidgetState();
}

class _PassagemWidgetState extends State<PassagemWidget> {
  int pontos = 0;
  List<Color> buttonColors = [Colors.green, Colors.green, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(3, (index) {
            final buttonText = String.fromCharCode(
                'A'.codeUnitAt(0) + index); // Converte para A, B, C
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  if (buttonColors[index] == Colors.green) {
                    buttonColors[index] = Colors.grey;
                    pontos += 10; // Adiciona 10 pontos ao clicar
                  } else {
                    buttonColors[index] = Colors.green;
                    pontos -= 10; // Remove 10 pontos ao clicar novamente
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColors[index], // Define a cor do botão
              ),
              child: Text(buttonText),
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
