// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class RampasWidget extends StatefulWidget {
  const RampasWidget({Key? key}) : super(key: key);

  @override
  _RampasWidgetState createState() => _RampasWidgetState();
}

class _RampasWidgetState extends State<RampasWidget> {
  int quantidade = 0;

  void atualizarPontos() {
    SharedAtom.pontos9 = quantidade * 10;
  }

  void incrementarQuantidade() {
    setState(() {
      quantidade++;
    });
    atualizarPontos();
  }

  void decrementarQuantidade() {
    if (quantidade > 0) {
      setState(() {
        quantidade--;
      });
      atualizarPontos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: decrementarQuantidade,
                child: const Icon(
                  Icons.remove,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '$quantidade',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: incrementarQuantidade,
                child: const Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Pontos: ${quantidade * 10}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }
}
