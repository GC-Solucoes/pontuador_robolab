// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VisualizarPontuacoesScreen extends StatefulWidget {
  const VisualizarPontuacoesScreen({Key? key}) : super(key: key);

  @override
  _VisualizarPontuacoesScreenState createState() =>
      _VisualizarPontuacoesScreenState();
}

class _VisualizarPontuacoesScreenState
    extends State<VisualizarPontuacoesScreen> {
  List<PontuacaoModel> _pontuacoes = [];
  List<bool> _selecionado = [];

  @override
  void initState() {
    super.initState();
    _carregarPontuacoes();
  }

  Future<void> _carregarPontuacoes() async {
    final List<PontuacaoModel> pontuacoes =
        await PontuacaoDatabase().getPontuacoes();

    setState(() {
      _pontuacoes = pontuacoes;
      _selecionado = List.generate(_pontuacoes.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pontuações Salvas'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _excluirPontuacoesSelecionadas();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _pontuacoes.length,
        itemBuilder: (context, index) {
          final pontuacao = _pontuacoes[index];
          final posicao = index + 1;
          return CheckboxListTile(
            title: Text(
                '$posicao° - ${pontuacao.nome} - ${pontuacao.pontuacao} - ${pontuacao.tempo}'),
            subtitle: Text('Data: ${pontuacao.data}'),
            value: _selecionado[index],
            onChanged: (value) {
              setState(() {
                _selecionado[index] = value!;
              });
            },
          );
        },
      ),
    );
  }

  void _excluirPontuacoesSelecionadas() async {
    final List<int> indicesSelecionados = _selecionado
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (indicesSelecionados.isNotEmpty) {
      final Database db = await PontuacaoDatabase().database;
      for (final index in indicesSelecionados) {
        await db.delete(
          'pontuacoes',
          where: 'id = ?',
          whereArgs: [_pontuacoes[index].id],
        );
      }
      await _carregarPontuacoes(); // Recarrega a lista após a exclusão

      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text('Pontuações excluídas com sucesso!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma pontuação selecionada para exclusão.'),
        ),
      );
    }
  }
}

class PontuacaoModel {
  int? id;
  String nome;
  double pontuacao;
  String tempo;
  DateTime data;

  PontuacaoModel(
      {this.id,
      required this.nome,
      required this.pontuacao,
      required this.tempo,
      required this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'pontuacao': pontuacao,
      'tempo': tempo.toString(),
      'data': data.toIso8601String(),
    };
  }

  factory PontuacaoModel.fromMap(Map<String, dynamic> map) {
    return PontuacaoModel(
      id: map['id'],
      nome: map['nome'],
      pontuacao: map['pontuacao'],
      tempo: map['tempo'],
      data: DateTime.parse(map['data']),
    );
  }
}

class PontuacaoDatabase {
  static const String dbName = 'pontuacoes.db';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pontuacoes(id INTEGER PRIMARY KEY, nome TEXT, pontuacao REAL, tempo TEXT, data TEXT)",
        );
      },
      version: 2,
    );
    return _database!;
  }

  Future<void> salvarPontuacao(PontuacaoModel pontuacao) async {
    final Database db = await database;

    await db.insert(
      'pontuacoes',
      pontuacao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PontuacaoModel>> getPontuacoes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pontuacoes');

    return List.generate(maps.length, (i) {
      return PontuacaoModel.fromMap(maps[i]);
    });
  }
}

class RankingScreen extends StatefulWidget {
  final List<PontuacaoModel> pontuacoes;

  const RankingScreen({Key? key, this.pontuacoes = const []}) : super(key: key);

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    widget.pontuacoes.sort((a, b) => b.pontuacao.compareTo(a.pontuacao));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.home_filled),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.pontuacoes.length,
        itemBuilder: (context, index) {
          final pontuacao = widget.pontuacoes[index];
          final posicao = index + 1;
          return ListTile(
            title: Text(
                '$posicao° - ${pontuacao.nome} - ${pontuacao.pontuacao} - ${pontuacao.tempo}'),
            subtitle: Text('Data: ${pontuacao.data}'),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingActionButton(
              onPressed: () {
                _limparPontuacoes();
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _limparPontuacoes() async {
    final Database db = await PontuacaoDatabase().database;
    await db.delete('pontuacoes');

    final List<PontuacaoModel> pontuacoes =
        await PontuacaoDatabase().getPontuacoes();

    setState(() {
      widget.pontuacoes.clear();
      widget.pontuacoes.addAll(pontuacoes);
    });

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text('Pontuações excluídas com sucesso!'),
      ),
    );
  }
}

class PontuacaoFinal extends StatelessWidget with RouteAware {
  const PontuacaoFinal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pontosSoma = SharedAtom.pontos +
        SharedAtom.pontos1 +
        SharedAtom.pontos2 +
        SharedAtom.pontos3 +
        SharedAtom.pontos4 +
        SharedAtom.pontos5 +
        SharedAtom.pontos6 +
        SharedAtom.pontos7 +
        SharedAtom.pontos8 +
        SharedAtom.pontos9;

    num resultado =
        ((((pontosSoma * SharedAtom.pontos13) * SharedAtom.pontos10) *
                SharedAtom.pontos11) *
            SharedAtom.pontos12);
    String result = resultado.toStringAsFixed(2);
    double result2 = double.parse(result);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.home_filled),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Pontuação Final',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              '$result2',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final pontuacaoModel = PontuacaoModel(
                  nome: SharedAtom.nome,
                  pontuacao: result2,
                  tempo: SharedAtom.cronometro,
                  data: DateTime.now(),
                );
                await PontuacaoDatabase().salvarPontuacao(pontuacaoModel);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pontuação salva com sucesso!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Salvar Pontuação',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20), // Adicionei um espaço entre os botões
            FloatingActionButton(
              onPressed: () {
                SharedAtom.resetPontuacao();
                Navigator.pushReplacementNamed(context, '/home');
              },
              backgroundColor: Colors.red,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons
                      .delete), // Adicionei um espaço entre o ícone e o texto
                ],
              ),
            ),
            // Adicionei um espaço entre os botões
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
