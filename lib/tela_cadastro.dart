// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _nomeUsuarioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      setState(() {
        isKeyboardVisible = isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 204, 130, 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25.0),
              Image.network(
                'https://github.com/coimbrox/pontuador_robolab/raw/0e074b208af47e2f635028f09c15b9692855d5db/lib/assets/image/icon-android.png',
                height: 100.0, // Ajuste conforme necessário
                width: 100.0, // Ajuste conforme necessário
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _nomeUsuarioController,
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Ajuste a largura conforme necessário
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25.0),
                        right: Radius.circular(20.0)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                cursorColor: Colors.black,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Ajuste a largura conforme necessário
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25.0),
                        right: Radius.circular(20.0)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                cursorColor: Colors.black,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Ajuste a largura conforme necessário
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25.0),
                        right: Radius.circular(20.0)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                cursorColor: Colors.black,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _confirmarSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirme a senha',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), // Ajuste a largura conforme necessário
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25.0),
                        right: Radius.circular(20.0)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                cursorColor: Colors.black,
              ),
              const SizedBox(height: 80.0),
              Visibility(
                visible: !isKeyboardVisible,
                child: SizedBox(
                  width: 220,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_senhaController.text ==
                          _confirmarSenhaController.text && _nomeUsuarioController.text != '' && _emailController.text != '' && _senhaController.text != '' && _confirmarSenhaController.text != '') {
                        final usuario = {
                          'nomeUsuario': _nomeUsuarioController.text,
                          'email': _emailController.text,
                          'senha': _senhaController.text
                        };

                        await _databaseHelper.insertUsuario(usuario);

                        Navigator.pushReplacementNamed(context, '/');
                      } 
                      if ( _nomeUsuarioController.text == '' && _emailController.text == '' && _senhaController.text == '' && _confirmarSenhaController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Todos os campos são obrigatórios'),
                          ),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('As senhas não coincidem'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height:
                      10.0), // Adicione um espaçamento adicional se necessário
            ],
          ),
        ),
      ),
    );
  }
}
