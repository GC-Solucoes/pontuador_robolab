import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/becos.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/gangorras.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/gap.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/intersecoes.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/kit_resgate.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/ladrilho_inicial_option.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/obstaculos.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/passagem.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/pontuacao-final.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/primeiro_marcador.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/rampas.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/redutores.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/segundo_marcador.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/terceiro_marcador.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/timer_controls_buttons.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/timer_display_widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/vitimas_invertida.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/vitimas_verde.widget.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/vitimas_vermelha.widget.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class MyHomePage extends StatefulWidget with RouteAware {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nomeController = TextEditingController();

  bool _isRunning = false;
  bool _ladrilhoInicialSelected = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _mostrarMensagemDeConfirmacao(String nome) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Mensagem de Confirmação'),
            content: Text('Nome enviado com sucesso: $nome'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

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

  List<int> listaPontos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.green,
              Colors.red,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      )),
                  child: TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      hintText: 'Nome da equipe',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    SharedAtom.nome = _nomeController.text;
                    _mostrarMensagemDeConfirmacao(SharedAtom.nome);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 70),
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
                ),
                const SizedBox(height: 20),
                const Text('1° Marcador',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const PrimeiroMarcadorWidget(),
                const SizedBox(height: 20),
                const Text('2° Marcador',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const SegundoMarcadorWidget(),
                const SizedBox(height: 20),
                const Text('3° Marcador',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const TerceiroMarcadorWidget(),
                const SizedBox(height: 20),
                const Text('Obstáculos',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const ObstaculosWidget(),
                const SizedBox(height: 20),
                const Text('Gangorras',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const GangorrasWidget(),
                const SizedBox(height: 20),
                const Text('Redutores',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const RedutoresWidget(),
                const SizedBox(height: 20),
                const Text('Intercessões',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const IntersecoesWidget(),
                const SizedBox(height: 20),
                const Text('Gap',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const GapWidget(),
                const SizedBox(height: 20),
                const Text('Passagem',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const PassagemWidget(),
                const SizedBox(height: 20),
                const Text('Becos',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const BecosWidget(),
                const SizedBox(height: 20),
                const Text('Rampas',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const RampasWidget(),
                const SizedBox(height: 20),
                const Text('Vítimas Resgatadas',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const Text('Vítimas Vivas Entregues na Área Verde',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const SizedBox(height: 20),
                const VitimasVerdeWidget(),
                const SizedBox(height: 20),
                const Text('Vítimas Mortas Entregues na Área Vermelha',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const SizedBox(height: 20),
                const VitimasVermelhoWidget(),
                const SizedBox(height: 20),
                const Text(
                    'Vítimas Vivas ou Mortas Entregues na Área Invertida',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const SizedBox(height: 20),
                const VitimasInvertidaWidget(),
                const SizedBox(height: 20),
                const Text('Kit Resgate Entregue',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const KitResgateWidget(),
                const SizedBox(height: 20),
                const Text('Cronômetro',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 20),
                TimerDisplayWidget(_stopwatch.elapsed),
                const SizedBox(height: 20),
                TimerControlButtons(
                  onStart: _startTimer,
                  onPause: _pauseTimer,
                  onReset: _resetTimer,
                ),
                const SizedBox(height: 20),
                const Text('FIM',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PontuacaoFinal()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Ver Pontuação Final',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
      ),
    );
  }
}