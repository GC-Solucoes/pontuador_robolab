import 'package:flutter/material.dart';

class VitimasInvertidaWidget extends StatefulWidget {
  const VitimasInvertidaWidget({Key? key}) : super(key: key);

  @override
  _VitimasInvertidaWidgetState createState() => _VitimasInvertidaWidgetState();
}

class _VitimasInvertidaWidgetState extends State<VitimasInvertidaWidget> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0, // Espaçamento horizontal entre os botões
          runSpacing: 8.0, // Espaçamento vertical entre as linhas de botões
          children: List.generate(11, (index) {
            final buttonText = (index).toString(); // Números de 0 a 10
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
