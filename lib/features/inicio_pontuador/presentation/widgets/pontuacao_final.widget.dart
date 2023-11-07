// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/pages/home_page.dart';

class PontuacaoFinal extends StatelessWidget {
  PontuacaoFinal({required this.pontos});

  final List<int> pontos;

  @override
  Widget build(BuildContext context) {
    List<int> pontuacaoTotal = ShareAtom.getListaPontos();

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
