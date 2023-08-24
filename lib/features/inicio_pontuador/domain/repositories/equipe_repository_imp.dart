abstract interface class EquipeRepositoryImp {
  Future<(Exception? ex, EquipeRepositoryImp? avaliadorEntity)> criar(
      String nomeEquipe,
      String nomeMembrosEquipe,
      String observacao,
      double notaFinal);
}
