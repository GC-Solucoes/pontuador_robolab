import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class VitimasVerdeWidget extends StatefulWidget {
  final VoidCallback? onPontos10Changed;
  final Function(int) onQuantidadeVitimasChanged; // Callback para atualizar a quantidade de vítimas

  const VitimasVerdeWidget({
    Key? key,
    this.onPontos10Changed,
    required this.onQuantidadeVitimasChanged,
  }) : super(key: key);

  @override
  _VitimasVerdeWidgetState createState() => _VitimasVerdeWidgetState();
}

class _VitimasVerdeWidgetState extends State<VitimasVerdeWidget> {
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
      SharedAtom.pontos10 = 1.0;
    }
    else {
      SharedAtom.pontos10 = calcularPontos();
    }
    widget.onPontos10Changed?.call();
    widget.onQuantidadeVitimasChanged(quantidadeVitimas); // Chama o callback para atualizar o KitResgateWidget
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
        ],
      ),
    );
  }

  double calcularPontos() {
    return quantidadeVitimas * 1.3;
  }
}
