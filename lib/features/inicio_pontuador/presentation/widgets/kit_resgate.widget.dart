import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class KitResgateWidget extends StatefulWidget {
  final VoidCallback? onPontos13Changed;
  final Function(int) onKitChanged;

  const KitResgateWidget({
    Key? key,
    this.onPontos13Changed,
    required this.onKitChanged,
  }) : super(key: key);

  @override
  _KitResgateWidgetState createState() => _KitResgateWidgetState();
}

class _KitResgateWidgetState extends State<KitResgateWidget> {
  String status = "Não Entregue";
  int quantidadeVitimas = 0; // Nova variável para armazenar a quantidade de vítimas
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
                        "Entregue na área verde (robô)",
                        "Entregue na área verde (trajeto)",
                        "Entregue na área vermelha (robô)",
                        "Entregue na área vermelha (trajeto)",
                        "Não entregue",
                      ][index];
                      selectedButtonIndex =
                          index; // Define o índice do botão selecionado

                      // Defina o multiplicador com base na seleção da área
                      if (index == 0) {
                        SharedAtom.pontos13 = 1.3;
                      } else if (index == 1) {
                        SharedAtom.pontos13 = 1.6;
                      } else if (index == 2) {
                        SharedAtom.pontos13 = 1.1;
                      } else if (index == 3) {
                        SharedAtom.pontos13 = 1.2;
                      } else {
                        SharedAtom.pontos13 = 1.0;
                      }
                      widget.onKitChanged(index); // Chame o callback com o índice selecionado
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
                            "Entregue na área verde (robô)",
                            "Entregue na área verde (trajeto)",
                            "Entregue na área vermelha (robô)",
                            "Entregue na área vermelha (trajeto)",
                            "Não entregue",
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
