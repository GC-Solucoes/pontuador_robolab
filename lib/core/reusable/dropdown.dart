import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class DropdownReusable extends StatefulWidget {
  final int tentativa; // Adiciona o parâmetro da tentativa

  const DropdownReusable({Key? key, required this.tentativa}) : super(key: key);

  @override
  State<DropdownReusable> createState() => _DropdownReusableState();
}

const List<String> list = <String>[
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10'
];

class _DropdownReusableState extends State<DropdownReusable> {
  String dropdownValue = list.first;
  int pontuacaoSelecionada = 0;
  int pontuacaoAnterior = 0;

  int mapearValorParaPontuacao(String valorSelecionado) {
    switch (valorSelecionado) {
      case '0':
        return 0;
      case '1':
        return 1;
      case '2':
        return 2;
      case '3':
        return 3;
      case '4':
        return 4;
      case '5':
        return 5;
      case '6':
        return 6;
      case '7':
        return 7;
      case '8':
        return 8;
      case '9':
        return 9;
      case '10':
        return 10;
      default:
        return 0;
    }
  }

  int calcularMultiplicador() {
    if (widget.tentativa == 1) {
      return 5;
    } else if (widget.tentativa == 2) {
      return 3;
    } else if (widget.tentativa == 3) {
      return 1;
    } else {
      return 1; // Valor padrão se a tentativa não for 1, 2 ou 3
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? value) {
            setState(() {
              pontuacaoAnterior = mapearValorParaPontuacao(dropdownValue);
              dropdownValue = value!;
              pontuacaoSelecionada = mapearValorParaPontuacao(value) * calcularMultiplicador();
              SharedAtom.pontos1 = SharedAtom.pontos1 - pontuacaoAnterior + pontuacaoSelecionada;
              if (pontuacaoSelecionada == 0) {
                SharedAtom.pontos1 = 0;
              }
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          icon: const Icon(
            Icons.arrow_drop_down, color: Colors.white 
          ),
          style: const TextStyle(
            color: Colors.black
          )
        ),
        Text(
          'Pontos: $pontuacaoSelecionada',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
