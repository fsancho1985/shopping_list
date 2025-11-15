import 'package:sqflite/sqflite.dart' as sql;

import '../models/compra.dart';



class CompraDao {
  final sql.Database db;

  CompraDao(this.db);

  Future<int> insertCompra(Compra compra) async {
    return await db.insert('compra', compra.toMap());
  }

  Future<int> updateCompra(Compra compra) async {
    return await db.update(
      'compra',
      compra.toMap(),
      where: 'id = ?',
      whereArgs: [compra.id],
    );
  }

  Future<List<Compra>> getComprasPendentes() async {
    final result = await db.query(
      'compra',
      where: 'comprado = ?',
      whereArgs: [0],
    );
    return result.map((map) => Compra.fromMap(map)).toList();
  }

  Future<int> marcarComoPendente(int id) async {
    return await db.update(
      'compra',
      { 'comprado': 0 },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> marcarComoComprado(int id) async {
    return await db.update(
      'compra',
      { 'comprado': 1 },
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<List<Compra>> getComprasPorLista(int listaId) async {
    final result = await db.rawQuery(
      '''
        SELECT c.*, p.nomeroduto, p.unidade
        FROM compra c
        INNER JOIN produto p ON c.produto_id = p.id
        WHERE c.lista_id = ?
        ORDER BY p.nomeproduto  
      ''',
      [listaId],
    );
    return result.map((map) => Compra.fromMap(map)).toList();
  }

  Future<Compra?> getCompraPorProdutoELista(int produtoId, int listaId) async {
    final result = await db.query(
      'compra',
      where: 'produto_id = ? AND lista_id = ?',
      whereArgs: [produtoId, listaId],
    );
     if (result.isNotEmpty) {
       return Compra.fromMap(result.first);
     }
     return null;
  }

  Future<List<Compra>> getComprasBasicasPorLista(int listaId) async {
    final result = await db.query(
      'compra',
      where: 'lista_id = ?',
      whereArgs: [listaId],
    );
    return result.map((map) => Compra.fromMap(map)).toList();
  }

  Future<int> deleteComprasPorLista(int listaId) async {
    return await db.delete(
      'compra',
      where: 'lista_id = ?',
      whereArgs: [listaId],
    );
  }

  Future<int> deleteCompra(int id) async {
    return await db.delete(
      'compra',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

}

