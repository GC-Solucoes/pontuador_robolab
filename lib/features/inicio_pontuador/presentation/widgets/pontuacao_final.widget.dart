// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class PontuacaoFinal extends StatelessWidget {
  PontuacaoFinal({required this.pontos});

  final List<int> pontos;

  int calcularPontuacaoTotal() {
    int total = 0;
    for (int ponto in pontos) {
      total += ponto;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    int pontuacaoTotal = calcularPontuacaoTotal();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação Final'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Sua pontuação final é:'),
              Text(
                '$pontuacaoTotal',
                style: Theme.of(context).textTheme.headline4,
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        tooltip: 'FIM',
        child: Icon(Icons.check),
      ),
    );
  }
}
