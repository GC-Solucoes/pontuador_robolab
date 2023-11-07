import 'package:flutter/material.dart';

class DropdownReusable extends StatefulWidget {
  const DropdownReusable({Key? key}) : super(key: key);

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
  double pontuacaoSelecionada = 0.0;

  double mapearValorParaPontuacao(String valorSelecionado) {
    switch (valorSelecionado) {
      case '0':
        return 0.0;
      case '1':
        return 1.0;
      case '2':
        return 2.0;
      case '3':
        return 3.0;
      case '4':
        return 4.0;
      case '5':
        return 5.0;
      case '6':
        return 6.0;
      case '7':
        return 7.0;
      case '8':
        return 8.0;
      case '9':
        return 9.0;
      case '10':
        return 10.0;
      default:
        return 0.0;
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
              dropdownValue = value!;
              pontuacaoSelecionada = mapearValorParaPontuacao(value);
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
            color: Colors.white
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
