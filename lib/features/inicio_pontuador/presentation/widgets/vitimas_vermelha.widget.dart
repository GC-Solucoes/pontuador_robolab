// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class VitimasVermelhoWidget extends StatefulWidget {
  const VitimasVermelhoWidget({Key? key}) : super(key: key);

  @override
  _VitimasVermelhoWidgetState createState() => _VitimasVermelhoWidgetState();
}

class _VitimasVermelhoWidgetState extends State<VitimasVermelhoWidget> {
  int quantidadeVitimas = 0; // Inicializado com 0
  num point = 0.0;

  void acrescentarQuantidade() {
    setState(() {
      quantidadeVitimas++;
      point = calcularPontos();
      atualizarPontos();
    });
  }

  void diminuirQuantidade() {
    if (quantidadeVitimas > 0) {
      setState(() {
        quantidadeVitimas--;
        point = calcularPontos();
        atualizarPontos();
      });
    }
  }

  void atualizarPontos() {
    if (point == 0) {
      SharedAtom.pontos11 = 1.0;
    } else {
      SharedAtom.pontos11 = calcularPontos();
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
                onTap: diminuirQuantidade,
                child: const Icon(
                  Icons.remove,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '$quantidadeVitimas',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: acrescentarQuantidade,
                child: const Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 40,
                ),
              ), 
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Quantidade de Vítimas: $quantidadeVitimas',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  num calcularPontos() {
    num z = pow(1.3, quantidadeVitimas);
    // Multiplica a quantidade de vítimas por 1.3 e retorna um double
    return z;
  }
}