// primeira_tela.dart
// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, unnecessary_type_check, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/pages/home_page.dart';
import 'database_helper.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String _rememberLoginKey = 'remember_login';
  bool _rememberLogin = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedLogin();
  }

  _loadRememberedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberLogin = prefs.getBool(_rememberLoginKey) ?? false;

    setState(() {
      _rememberLogin = rememberLogin;
      if (_rememberLogin) {
        String savedUsername = prefs.getString('saved_username') ?? '';
        String savedPassword = prefs.getString('saved_password') ?? '';

        _usuarioController.text = savedUsername;
        _senhaController.text = savedPassword;
      }
    });
  }

  _saveRememberedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_rememberLoginKey, _rememberLogin);

    if (_rememberLogin) {
      prefs.setString('saved_username', _usuarioController.text);
      prefs.setString('saved_password', _senhaController.text);
    }
  }

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
              height: 200.0, // Ajuste conforme necessário
              width: 200.0, // Ajuste conforme necessário
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
            SizedBox(height: 15.0),
            Row(
              children: [
                Checkbox(
                  value: _rememberLogin,
                  onChanged: (value) {
                    setState(() {
                      _rememberLogin = value ?? false;
                    });
                  },
                ),
                Text('Lembrar login'),
              ],
            ),
            SizedBox(height: 30.0),
            SizedBox(
              width: 220,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  final usuarios = await _databaseHelper.getUsuarios();
                  final usuarioEncontrado = usuarios.any(
                    (user) =>
                        user['nomeUsuario'] == _usuarioController.text &&
                        user['senha'] == _senhaController.text,
                  );

                  if (usuarioEncontrado) {
                    _saveRememberedLogin();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Credenciais inválidas'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
            SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/cadastro');
              },
              child: Text(
                'Não tenho cadastro',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 70),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Pontuador RoboLab Caxias - Versão 1.2\nDezembro de 2023\nDesenvolvido por Gabriel Coimbra de Oliveira da Silva e Leonardo Franco Lima sob orientação dos professores Greice da Silva Lorenzzetti Andreis e André Augusto Andreis\nIFRS - Campus Caxias do Sul',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
