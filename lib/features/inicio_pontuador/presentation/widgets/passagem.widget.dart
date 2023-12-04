import 'package:flutter/material.dart';
import 'package:pontuador_robolab/core/atom/shared_atom.dart';

class PassagemWidget extends StatefulWidget {
  const PassagemWidget({Key? key}) : super(key: key);

  @override
  _PassagemWidgetState createState() => _PassagemWidgetState();
}

class _PassagemWidgetState extends State<PassagemWidget> {
  List<Color> buttonColors = [Colors.green, Colors.green, Colors.green];
  List<bool> buttonSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(3, (index) {
              final buttonText =
                  String.fromCharCode('A'.codeUnitAt(0) + index); // Converte para A, B, C
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (!buttonSelected[index]) {
                      buttonSelected[index] = true;
                      SharedAtom.pontos7 += 10; // Adiciona 10 pontos ao clicar
                    } else {
                      buttonSelected[index] = false;
                      SharedAtom.pontos7 -= 10; // Remove 10 pontos ao clicar novamente
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonSelected[index] ? Colors.green : Colors.green, // Define a cor do botão
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: buttonSelected[index] ? Colors.white : Colors.black,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Pontos: ${SharedAtom.pontos7}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
