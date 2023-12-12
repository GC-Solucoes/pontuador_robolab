import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class LadrilhoInicialOption extends StatelessWidget {
  final bool selected;
  final ValueChanged<bool> toggleSelection;

  const LadrilhoInicialOption({
    Key? key,
    required this.selected,
    required this.toggleSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ladrilho Inicial: ',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                toggleSelection(true);
                if (!selected) {
                  SharedAtom.pontos += 5;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selected ? Colors.green : null,
              ),
              child: const Text('Sim'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                toggleSelection(false);
                if (SharedAtom.pontos == 5) {
                  SharedAtom.pontos -= 5;
                }
                if (SharedAtom.pontos > 5) {
                  SharedAtom.pontos -= SharedAtom.pontos;
                }
              },
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
            'Pontuação: ${getPoints()} pontos',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  int getPoints() {
    return selected ? 5 : 0;
  }
}
