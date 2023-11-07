import 'package:flutter/material.dart';

class LadrilhoInicialOption extends StatelessWidget {
  final bool selected;
  final ValueChanged<bool> toggleSelection;
  final double pontuacao;

  const LadrilhoInicialOption({
    super.key,
    required this.selected,
    required this.toggleSelection,
    required this.pontuacao,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ladrilho Inicial: ',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => toggleSelection(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: selected ? Colors.green : null,
              ),
              child: const Text('Sim'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => toggleSelection(false),
              style: ElevatedButton.styleFrom(
                backgroundColor: !selected ? Colors.red : null,
              ),
              child: const Text('Não'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: selected,
          child: Text(
            'Pontuação: $pontuacao pontos',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
