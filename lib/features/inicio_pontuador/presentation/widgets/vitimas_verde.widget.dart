import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class VitimasVerdeWidget extends StatefulWidget {
  const VitimasVerdeWidget({Key? key}) : super(key: key);

  @override
  _VitimasVerdeWidgetState createState() => _VitimasVerdeWidgetState();
}

class _VitimasVerdeWidgetState extends State<VitimasVerdeWidget> {
  int quantidadeVitimas = -1; // Inicializado com -1 para nenhum botão estar selecionado

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
                    quantidadeVitimas = index; // Define a quantidade de vítimas para o número clicado
                    SharedAtom.pontos10 = calcularPontos(); // Adiciona os pontos em SharedAtom.pontos10
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
    // Multiplica a quantidade de vítimas por 1.3 e retorna um double
    return quantidadeVitimas * 1.3;
  }
}
