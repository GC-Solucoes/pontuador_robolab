import 'package:flutter/material.dart';

class ObstaculosWidget extends StatefulWidget {
  const ObstaculosWidget({Key? key}) : super(key: key);

  @override
  _ObstaculosWidgetState createState() => _ObstaculosWidgetState();
}

class _ObstaculosWidgetState extends State<ObstaculosWidget> {
  int pontos = 0;

  List<bool> buttonStates = List.generate(6, (index) => false);

  void atualizarPontos() {
    int novoPonto = 0;

    for (int i = 0; i < buttonStates.length; i++) {
      if (buttonStates[i]) {
        novoPonto += 1;
      }
    }
    setState(() {
      pontos = novoPonto * 15;
    });
    // ShareAtom.setPontos(pontos);
  }

  void atualizarEstado(int index) {
    setState(() {
      buttonStates[index] = !buttonStates[index];
    });
    atualizarPontos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.width / 8;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            spacing: buttonSize / 4,
            runSpacing: buttonSize / 4,
            children: [
              for (int i = 0; i < 6; i++)
                InkWell(
                  onTap: () {
                    atualizarEstado(i);
                  },
                  child: buildButton(i, buttonSize),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Pontos: $pontos',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget buildButton(int index, double buttonSize) {
    final buttonText = (index + 1).toString();
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: buttonStates[index] ? Colors.green : Colors.green,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.green,
          width: buttonSize / 6,
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonStates[index] ? Colors.white : Colors.black,
            fontSize: buttonSize / 3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
