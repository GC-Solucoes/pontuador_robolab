import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/ladrilho_inicial_option.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/primeiro_marcador.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/timer_controls_buttons.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/timer_display_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool _isRunning = false;

  final TextEditingController _evaluatorNameController =
      TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();

  bool _ladrilhoInicialSelected = false;
  final int _pontuacaoLadrilhoInicial = 0;

  void _toggleLadrilhoInicial(bool value) {
    setState(() {
      _ladrilhoInicialSelected = value;
    });
  }

  void _startTimer() {
    if (!_isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
        setState(() {});
      });
      _isRunning = true;
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _isRunning = false;
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pontuador - Robolab'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CampoNomeAvaliador(controller: _evaluatorNameController),
            const SizedBox(height: 10),
            CampoNomeEquipe(controller: _teamNameController),
            const SizedBox(height: 20),
            TimerDisplayWidget(_stopwatch.elapsed),
            const SizedBox(height: 20),
            TimerControlButtons(
              onStart: _startTimer,
              onPause: _pauseTimer,
              onReset: _resetTimer,
            ),
            const SizedBox(height: 20),
            LadrilhoInicialOption(
              selected: _ladrilhoInicialSelected,
              toggleSelection: _toggleLadrilhoInicial,
              pontuacao: 5,
            ),
            const SizedBox(height: 20),
            const PrimeiroMarcadorWidget(
              primeiraTentativa: 1,
              segundaTentativa: 2,
              terceiraTentativa: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class CampoNomeAvaliador extends StatelessWidget {
  final TextEditingController controller;

  const CampoNomeAvaliador({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Nome do Avaliador'),
    );
  }
}

class CampoNomeEquipe extends StatelessWidget {
  final TextEditingController controller;

  const CampoNomeEquipe({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Nome da Equipe'),
    );
  }
}
