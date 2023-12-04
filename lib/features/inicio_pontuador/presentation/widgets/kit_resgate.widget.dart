import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class KitResgateWidget extends StatefulWidget {
  const KitResgateWidget({Key? key}) : super(key: key);

  @override
  _KitResgateWidgetState createState() => _KitResgateWidgetState();
}

class _KitResgateWidgetState extends State<KitResgateWidget> {
  String status = "Não Entregue";
  double multiplicador = 1.0; // Inicializado como 1.0 (sem multiplicação)
  int selectedButtonIndex = -1; // Índice do botão selecionado

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
            children: [
              for (int index = 0; index < 5; index++)
                InkWell(
                  onTap: () {
                    setState(() {
                      status = [
                        "Não entregue",
                        "Entregue na área vermelha (Robô)",
                        "Entregue na área vermelha (Trajeto)",
                        "Entregue na área verde (Robô)",
                        "Entregue na área verde (Trajeto)",
                      ][index];
                      selectedButtonIndex =
                          index; // Define o índice do botão selecionado

                      // Defina o multiplicador com base na seleção da área
                      if (index == 3 || index == 4) {
                        multiplicador = 1.3;
                        SharedAtom.pontos13 = multiplicador; // Na área dos vivos
                      } else {
                        multiplicador = 1.1;
                        SharedAtom.pontos13 = multiplicador;// Na área dos mortos
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedButtonIndex == index
                          ? Colors.green
                          : Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          [
                            "Não Entregue",
                            "Entregue na área vermelha (robo)",
                            "Entregue na área vermelha (trajeto)",
                            "Entregue na área verde (robo)",
                            "Entregue na área verde (trajeto)",
                          ][index],
                          style: TextStyle(
                            color: selectedButtonIndex == index
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Status selecionado: $status',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Multiplicador: $multiplicador',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
