// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class VitimasInvertidaWidget extends StatefulWidget {
  const VitimasInvertidaWidget({Key? key}) : super(key: key);

  @override
  _VitimasInvertidaWidgetState createState() => _VitimasInvertidaWidgetState();
}

class _VitimasInvertidaWidgetState extends State<VitimasInvertidaWidget> {
  int valor = -1;  // Inicializado com -1 para nenhum botão estar selecionado
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
            children: List.generate(11, (index) {
              final buttonText = (index).toString();
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    valor = index; // Define o valor para o número clicado
                    
                    point = calcularPontos();

                    if (point == 0) {
                        SharedAtom.pontos12 = 1.0;
                    }
                    else {
                        SharedAtom.pontos12 = calcularPontos();
                    }

                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: valor == index ? Colors.green : Colors.green,
                  // Define a cor do botão com base na seleção
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: valor == index ? Colors.white : Colors.black,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Quantidade de Vítimas: ${valor == -1 ? "Nenhuma" : valor}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  double calcularPontos() {
    double z = valor * 1.1;
    return z;
  }

}
