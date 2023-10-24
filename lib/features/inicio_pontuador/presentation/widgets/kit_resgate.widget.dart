// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      multiplicador = 1.3; // Na área dos vivos
                    } else {
                      multiplicador = 1.1; // Na área dos mortos
                    }
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: selectedButtonIndex == index
                        ? Colors.grey
                        : Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      [
                        "Não Entregue",
                        "Entregue na área vermelha (robo)",
                        "Entregue na área vermelha (trajeto)",
                        "Entregue na área verde (robo)",
                        "Entregue na área verde (trajeto)",
                      ][index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Status selecionado: $status',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          'Multiplicador: $multiplicador',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
