class LocalStorage {
  static LocalStorage? _instance;
  final Map<String, double> _storage = {};
  LocalStorage._();

  static LocalStorage get instance {
    _instance ??= LocalStorage._();
    return _instance!;
  }

  Future<void> save(String key, double pontuacao) async {
    _storage[key] = pontuacao;
  }
}
