import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const _dbName = 'shoopingList.db';
  static const _dbVersion = 2;

  static Future<Database> openDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _upgradeToVersion2(db);
        }
      },
    );
  }

  static Future<void> _upgradeToVersion2(Database db) async {
    await db.execute('''
      CREATE TABLE lista_compra (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_criacao INTEGER NOT NULL,
        ativa INTEGER DEFAULT 1
      );
    ''');
  }

  static Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        nome TEXT NOT NULL,
        senha TEXT NOT NULL,
        cep TEXT,
        logradouro TEXT,
        numero TEXT,
        bairro TEXT,
        cidade TEXT,
        estado TEXT,
        uf TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE produto (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_produto TEXT NOT NULL,
        unidade TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE compra (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        produto_id INTEGER NOT NULL,
        quantidade REAL NOT NULL,
        comprado INTEGER DEFAULT 0,
        lista_id INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (produto_id) REFERENCES produto(id)
        FOREIGN KEY (lista_id) REFERENCES lista_compra(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE lista_compra (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_criacao INTEGERE NOT NULL,
        ativa INTEGER DEFAULT 1
      );
    ''');

    await db.execute('''
      INSERT INTO lista_compra (nome, data_criacao, ativa)
        VALUES ('lista Principal', strftime('%s', 'now'), 1);
    ''');
  }

}