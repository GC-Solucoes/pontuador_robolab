// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class VitimasInvertidaWidget extends StatefulWidget {
  final VoidCallback? onPontos12Changed;
  final Function(int) onQuantidadeVitimasChanged;

  const VitimasInvertidaWidget({
    Key? key,
    this.onPontos12Changed,
    required this.onQuantidadeVitimasChanged,
  }) : super(key: key);

  @override
  _VitimasInvertidaWidgetState createState() => _VitimasInvertidaWidgetState();
}

class _VitimasInvertidaWidgetState extends State<VitimasInvertidaWidget> {
  int quantidadeVitimas = 0; // Inicializado com 0

  void acrescentarQuantidade() {
    setState(() {
      quantidadeVitimas++;
    });
    atualizarPontos();
  }

  void diminuirQuantidade() {
    if (quantidadeVitimas > 0) {
      setState(() {
        quantidadeVitimas--;
      });
      atualizarPontos();
    }
  }

  void atualizarPontos() {
    if (quantidadeVitimas == 0) {
      SharedAtom.pontos12 = 1.0;
    }
    else {
      SharedAtom.pontos12 = calcularPontos();
    }
    widget.onPontos12Changed?.call();
    widget.onQuantidadeVitimasChanged(quantidadeVitimas);
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
        ],
      ),
    );
  }

  double calcularPontos() {
    return quantidadeVitimas * 1.1;
  }
}