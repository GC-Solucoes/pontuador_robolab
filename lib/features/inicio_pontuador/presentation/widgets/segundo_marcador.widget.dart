import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/reusable/dropdown.dart';

class SegundoMarcadorWidget extends StatelessWidget {
  const SegundoMarcadorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '1ª Tentativa:',
                style: TextStyle(
                  color: Colors.white
                )
              ),
              DropdownReusable(tentativa: 1),
            ],
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '2ª Tentativa:',
                style: TextStyle(
                  color: Colors.white
                )
              ),
              DropdownReusable(tentativa: 2),
            ],
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '3ª Tentativa:',
                style: TextStyle(
                  color: Colors.white
                )
              ),
              DropdownReusable(tentativa: 3),
            ],
          ),
        ),
      ],
    );
  }
}
