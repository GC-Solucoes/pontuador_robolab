import 'package:pontuador_robolab/features/inicio_pontuador/domain/entities/avaliador_entity.dart';

abstract interface class AvaliadorRepositoryImp {
  Future<(Exception? ex, AvaliadorEntity? avaliadorEntity)> criar(
    String nomeAvaliador,
  );
}
