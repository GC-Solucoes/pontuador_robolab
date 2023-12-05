// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class VitimasVermelhoWidget extends StatefulWidget {
  const VitimasVermelhoWidget({Key? key}) : super(key: key);

  @override
  _VitimasVermelhoWidgetState createState() => _VitimasVermelhoWidgetState();
}

class _VitimasVermelhoWidgetState extends State<VitimasVermelhoWidget> {
  int quantidadeVitimas = -1; // Inicializado com -1 para nenhum botão estar selecionado
  double point = 0.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(6, (index) {
              final buttonText = (index).toString();
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    quantidadeVitimas = index;
                    point = calcularPontos();
                     // Define a quantidade de vítimas para o número clicado
                    if (point == 0) {
                      SharedAtom.pontos11 = 1.0;
                    } else {
                      SharedAtom.pontos11 = calcularPontos();
                    } // Adiciona os pontos em SharedAtom.pontos11
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: quantidadeVitimas == index ? Colors.green : Colors.green,
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: quantidadeVitimas == index ? Colors.white : Colors.black,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Quantidade de Vítimas: ${quantidadeVitimas == -1 ? "Nenhuma" : quantidadeVitimas}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  double calcularPontos() {
    double z = quantidadeVitimas * 1.3;
    // Multiplica a quantidade de vítimas por 1.3 e arredonda para o inteiro mais próximo
    return z;
  }
}
