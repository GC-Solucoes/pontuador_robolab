import 'package:flutter/material.dart';

class PassagemWidget extends StatefulWidget {
  const PassagemWidget({Key? key}) : super(key: key);

  @override
  _PassagemWidgetState createState() => _PassagemWidgetState();
}

class _PassagemWidgetState extends State<PassagemWidget> {
  int pontos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0, // Espaçamento horizontal entre os botões
          runSpacing: 8.0, // Espaçamento vertical entre as linhas de botões
          children: List.generate(3, (index) {
            final buttonText = String.fromCharCode(
                'A'.codeUnitAt(0) + index); // Converte para A, B, C
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  pontos += 10; // Adiciona 15 pontos a cada clique
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
