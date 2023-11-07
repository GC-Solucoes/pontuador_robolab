import 'package:share/share.dart';
import 'package:pontuador_robolab/features/inicio_pontuador/presentation/widgets/obstaculos.widget.dart';

class ShareAtom {
  static int pontos = 0;
  static List<int> listaPontos = [];

  static void setPontos(int novosPontos) {
    pontos = novosPontos;
  }

  static int getPontos() {
    return pontos;
  }

  static List<int> getListaPontos() {
    return listaPontos;
  }
}
