import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/gangorras.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/gap.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/intersecoes.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/ladrilho_inicial_option.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/obstaculos.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/primeiro_marcador.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/redutores.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/segundo_marcador.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/terceiro_marcador.widget.dart';
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
  final double _pontuacaoLadrilhoInicial = 0;

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
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
              const Text('1° Marcador',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const SizedBox(height: 10),
              const PrimeiroMarcadorWidget(),
              const SizedBox(height: 20),
              const Text('2° Marcador',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const SizedBox(height: 10),
              const SegundoMarcadorWidget(),
              const SizedBox(height: 20),
              const Text('3° Marcador',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const SizedBox(height: 10),
              const TerceiroMarcadorWidget(),
              const SizedBox(height: 5),
              const Text('Obstáculos',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const ObstaculosWidget(),
              const SizedBox(height: 5),
              const Text('Gangorras',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const GangorrasWidget(),
              const SizedBox(height: 5),
              const Text('Redutores',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const RedutoresWidget(),
              const SizedBox(height: 5),
              const Text('Iterseções',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const IntersecoesWidget(),
              const SizedBox(height: 5),
              const Text('Gap',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const GapWidget(),
            ],
          ),
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
      decoration: InputDecoration(
        labelText: 'Nome do Avaliador',
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Define o raio do arredondamento
        ),
      ),
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
      decoration: InputDecoration(
        labelText: 'Nome da Equipe',
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Define o raio do arredondamento
        ),
      ),
    );
  }
}
