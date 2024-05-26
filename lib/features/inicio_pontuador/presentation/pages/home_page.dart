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
    String formattedDuration = _formatDuration(_stopwatch.elapsed);

    SharedAtom.cronometro = formattedDuration;
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _isRunning = false;
    }
  }

  String _formatDuration(Duration duration) {
    int minutos = duration.inMinutes;
    int segundos = duration.inSeconds % 60;
    int milissegundos = (duration.inMilliseconds % 1000);

    String formattedMinutes = minutos.toString().padLeft(2, '0');
    String formattedSeconds = segundos.toString().padLeft(2, '0');
    String formattedMilliseconds =
        (milissegundos ~/ 10).toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds:$formattedMilliseconds';
  }

  void _resetTimer() {
    _stopwatch.reset();
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    }
    setState(() {});
  }

  num calcMulti() {
    return SharedAtom.pontos14 = SharedAtom.pontos13 *
        (SharedAtom.pontos10 * SharedAtom.pontos11 * SharedAtom.pontos12);
  }

  String formatarPontos(num pontos) {
    return pontos.toStringAsFixed(2);
  }

  List<int> listaPontos = [];

  int _selectedKitIndex = -1; // Índice do kit de resgate selecionado

  // Função para lidar com a mudança do kit de resgate
  void _handleKitChanged(int index) {
    setState(() {
      _selectedKitIndex = index;
    });
  }

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
                    ),
                  ),
                  child: TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      hintText: 'Nome da equipe',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      SharedAtom.nome = value;
                    },
                  ),
                ),
                const SizedBox(height: 60),
                LadrilhoInicialOption(
                  selected: _ladrilhoInicialSelected,
                  toggleSelection: _toggleLadrilhoInicial,
                ),
                const SizedBox(height: 40),
                const Text(
                  '1° Marcador',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                const PrimeiroMarcadorWidget(),
                const SizedBox(height: 20),
                const Text(
                  '2° Marcador',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                const SegundoMarcadorWidget(),
                const SizedBox(height: 20),
                const Text(
                  '3° Marcador',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                const TerceiroMarcadorWidget(),
                const SizedBox(height: 70),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Obstáculos',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        ObstaculosWidget(),
                        SizedBox(height: 40),
                        Text(
                          'Gangorras',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        GangorrasWidget(),
                        SizedBox(height: 40),
                        Text(
                          'Redutores',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        RedutoresWidget(),
                        SizedBox(height: 40),
                        Text(
                          'Intersecções',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        IntersecoesWidget(),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          'Gaps',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        GapWidget(),
                        SizedBox(height: 40),
                        Text(
                          'Passagens',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        PassagemWidget(),
                        SizedBox(height: 40),
                        Text(
                          'Becos',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        BecosWidget(),
                        SizedBox(height: 40),
                        Text(
                          'Rampas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        RampasWidget(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                const Text(
                  'Vítimas Resgatadas',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Vivas na Área Verde',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                VitimasVerdeWidget(
                  onQuantidadeVitimasChanged: _handleQuantidadeVitimasChanged,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Mortas na Área Vermelha',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                VitimasVermelhoWidget(
                  onQuantidadeVitimasChanged: _handleQuantidadeVitimasChanged,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Vivas ou Mortas na Área Invertida',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                VitimasInvertidaWidget(
                  onQuantidadeVitimasChanged: _handleQuantidadeVitimasChanged,
                ),
                const SizedBox(height: 60),
                const Text(
                  'Kit de Resgate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20),
                KitResgateWidget(
                  onKitChanged: _handleKitChanged,
                ),
                const SizedBox(height: 20),
                Text(
                  'Multiplicador Final: ${formatarPontos(calcMulti())}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PontuacaoFinal(),
                      ),
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
                    'Pontuação final',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VisualizarPontuacoesScreen(),
                      ),
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
                    'Pontuações salvas',
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
          backgroundColor: const Color.fromARGB(255, 39, 199, 60),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          actions: [
            TimerDisplayWidget(
              _stopwatch.elapsed,
              verticalPadding: 18.0,
              rightPadding: 10.0,
            ),
            TimerControlButtons(
              onStart: _startTimer,
              onPause: _pauseTimer,
              onReset: _resetTimer,
            ),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }

  void _handleQuantidadeVitimasChanged(int quantidadeVitimas) {
    setState(() {});
  }
}
