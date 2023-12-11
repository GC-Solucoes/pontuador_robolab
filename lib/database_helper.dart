import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'usuarios';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'usuarios_database.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeUsuario TEXT,
        email TEXT,
        senha TEXT
      )
      ''');
    });
  }

  Future<void> insertUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    await db.insert(tableName, usuario);
  }

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<void> deleteAllUsuarios() async {
    final db = await database;
    await db.delete(tableName);
  }

  Future<bool> verificarEmailCadastrado(String email) async {
  final db = await database;
  List<Map<String, dynamic>> result = await db.query(
    'usuarios',
    columns: ['email'],
    where: 'email = ?',
    whereArgs: [email],
  );

  return result.isNotEmpty;
}
}