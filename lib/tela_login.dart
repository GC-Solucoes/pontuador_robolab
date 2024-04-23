// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/pages/home_page.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 204, 130, 1),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://raw.githubusercontent.com/GC-Solucoes/pontuador_robolab/dca206b6dea9f8ac6fd7ec0775f82e7e9ada81cc/lib/assets/image/2023-12-20-Logo.png',
                  height: 350.0,
                  width: 350.0,
                ),
                const SizedBox(height: 70.0),
                SizedBox(
                  width: 220,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      backgroundColor: const Color.fromRGBO(82, 229, 231, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                const SizedBox(height: 200.0),
                const Text(
                  'Pontuador RoboLab Caxias Versão 1.2 Dezembro de 2023 Desenvolvido por Gabriel Coimbra de Oliveira da Silva e Leonardo Franco Lima sob orientação dos professores Greice da Silva Lorenzzetti Andreis e André Augusto Andreis IFRS - Campus Caxias do Sul',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
