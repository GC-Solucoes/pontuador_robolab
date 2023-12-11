// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/tela_cadastro.dart';
import 'tela_login.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pontuador - Robolab',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/', // Defina a rota inicial
      routes: {
        '/': (context) => TelaLogin(),  // Rota inicial
        '/home': (context) => MyHomePage(), 
        '/cadastro': (context) => TelaCadastro(), // Rota para a página principal
        // Adicione outras rotas aqui, se necessário
      },
    );
  }
}
