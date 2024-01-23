// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/pages/home_page.dart';
import 'database_helper.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String _rememberLoginKey = 'remember_login';
  final FocusNode _usuarioFocus = FocusNode();
  final FocusNode _senhaFocus = FocusNode();
  bool _rememberLogin = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedLogin();
    _usuarioFocus.addListener((_handleFocusChange));
    _senhaFocus.addListener((_handleFocusChange));
  }

  void _handleFocusChange() {
    setState(() {
      _isEditing = _usuarioFocus.hasFocus || _senhaFocus.hasFocus;
    });
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
                  'https://github.com/coimbrox/pontuador_robolab/raw/0e074b208af47e2f635028f09c15b9692855d5db/lib/assets/image/icon-android.png',
                  height: 180.0,
                  width: 180.0,
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Usuário',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
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
                    const Text('Lembrar login'),
                  ],
                ),
                const SizedBox(height: 30.0),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Credenciais inválidas'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      backgroundColor: const Color.fromRGBO(82, 229, 231, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/cadastro');
                  },
                  child: const Text(
                    'Não tenho cadastro',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                const Text(
                  'Pontuador RoboLab Caxias Versão 1.2 Dezembro de 2023 Desenvolvido por Gabriel Coimbra de Oliveira da Silva e Leonardo Franco Lima sob orientação dos professores Greice da Silva Lorenzzetti Andreis e André Augusto Andreis IFRS - Campus Caxias do Sul',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white
                  ),
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
