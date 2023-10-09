import 'package:flutter/material.dart';

class VitimasVermelhoWidget extends StatefulWidget {
  const VitimasVermelhoWidget({Key? key}) : super(key: key);

  @override
  _VitimasVermelhoWidgetState createState() => _VitimasVermelhoWidgetState();
}

class _VitimasVermelhoWidgetState extends State<VitimasVermelhoWidget> {
  int valor = -1; // Inicializado com -1 para nenhum botão estar selecionado

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(6, (index) {
            final buttonText = (index).toString();
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  valor = index; // Define o valor para o número clicado
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: valor == index ? Colors.grey : Colors.green,
                // Define a cor do botão com base na seleção
              ),
              child: Text(buttonText),
            );
          }),
        ),
        const SizedBox(height: 10),
        Text(
          'Quantidade de Vítimas: ${valor == -1 ? "Nenhuma" : valor}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
