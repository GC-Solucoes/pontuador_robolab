import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/reusable/dropdown.dart';

class PrimeiroMarcadorWidget extends StatelessWidget {
  final int primeiraTentativa;
  final int segundaTentativa;
  final int terceiraTentativa;

  const PrimeiroMarcadorWidget({
    super.key,
    required this.primeiraTentativa,
    required this.segundaTentativa,
    required this.terceiraTentativa,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('1 Marcador:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('1ª Tentativa: $primeiraTentativa'),
            const DropdownReusable()
          ],
        ),
      ],
    );
  }
}
