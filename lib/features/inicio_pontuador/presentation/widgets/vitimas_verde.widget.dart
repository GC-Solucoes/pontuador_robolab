import 'package:flutter/material.dart';

class VitimasVerdeWidget extends StatefulWidget {
  const VitimasVerdeWidget({Key? key}) : super(key: key);

  @override
  _VitimasVerdeWidgetState createState() => _VitimasVerdeWidgetState();
}

class _VitimasVerdeWidgetState extends State<VitimasVerdeWidget> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0, // Espaçamento horizontal entre os botões
          runSpacing: 8.0, // Espaçamento vertical entre as linhas de botões
          children: List.generate(6, (index) {
            final buttonText = (index).toString(); // Números de 0 a 5
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  valor = index; // Define o valor para o número clicado
                });
              },
              child: Text(buttonText),
            );
          }),
        ),
        const SizedBox(
            height: 10), // Espaço entre os botões e a exibição do valor
        Text(
          'Quantidade de Vítimas: $valor',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
