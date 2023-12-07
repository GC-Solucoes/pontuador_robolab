// primeira_tela.dart
// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/pages/home_page.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 204, 130, 1),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://github.com/coimbrox/pontuador_robolab/raw/0e074b208af47e2f635028f09c15b9692855d5db/lib/assets/image/icon-android.png',
              height: 100.0, // Ajuste conforme necessário
              width: 100.0,  // Ajuste conforme necessário
            ),
            SizedBox(height: 16.0),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            SizedBox(
              width: 220,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica de autenticação simulada
                  if (_usuarioController.text == 'usuario' &&
                      _senhaController.text == 'senha') {
                    // Credenciais válidas, navegue para a segunda tela
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    // Credenciais inválidas, exiba uma mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Credenciais inválidas'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  backgroundColor: Color.fromRGBO(82, 229, 231, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
