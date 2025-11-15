import 'package:app_shopping_list/db/compra_dao.dart';
import 'package:app_shopping_list/db/db_helper.dart';
import 'package:app_shopping_list/db/lista_compra_dao.dart';
import 'package:app_shopping_list/db/usuario_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../db/produto_dao.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await DBHelper.openDB();
    return _database!;
  }

  static Future<CompraDao> get compraDao async {
    final db = await database;
    return CompraDao(db);
  }

  static Future<ProdutoDao> get produtoDao async {
    final db = await database;
    return ProdutoDao(db);
  }

  static Future<UsuarioDao> get usuarioDao async {
    final db = await database;
    return UsuarioDao(db);
  }

  static Future<ListaCompraDao> get listaCompraDao async {
    final db = await database;
    return ListaCompraDao(db);
  }

  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}