abstract interface class RoundRepositoryImp {
  Future<(Exception? ex, RoundRepositoryImp? avaliadorEntity)> criar(
    int numeroRound,
    String cronometroRound,
    String pontuacaoRound,
  );
}
