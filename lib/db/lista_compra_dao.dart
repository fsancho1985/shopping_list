import 'package:sqflite/sqflite.dart' as sql;

import '../models/lista_compra.dart';

class ListaCompraDao {
  final sql.Database db;

  ListaCompraDao(this.db);

  Future<int> insertLista(ListaCompra lista) async {
    return await db.insert('lista_compra', lista.toMap());
  }

  Future<ListaCompra?> getListaAtiva() async {
    final result = await db.query(
      'lista_compra',
      where: 'ativa = ?',
      whereArgs: [1],
      orderBy: 'data_criacao DESC',
      limit: 1,
    );
    return result.isNotEmpty ? ListaCompra.fromMap(result.first) : null;
  }

  Future<List<ListaCompra>> getTodasListas() async {
    final result = await db.query(
      'lista_compra',
      orderBy: 'data_criacao DESC',
    );
    return result.map((map) => ListaCompra.fromMap(map)).toList();
  }

  Future<ListaCompra?> getListaPorId(int id) async {
    final result = await db.query(
      'lista_compra',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? ListaCompra.fromMap(result.first) : null;
  }

  Future<int> desativarTodasListas() async {
    return await db.update(
      'lista_compra',
      { 'ativa': 0 },
      where: 'ativa = ?',
      whereArgs: [1],
    );
  }

  Future<int> ativarLista(int id) async {
    await desativarTodasListas();
    return await db.update(
      'lista_compras',
      { 'ativa': 1 },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteLista(int id) async {
    await db.delete(
        'compra',
        where: 'lista_id = ?',
      whereArgs: [id],
    );
    return await db.delete(
      'lista_compra',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}