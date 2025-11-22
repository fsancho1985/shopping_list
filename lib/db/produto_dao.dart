import 'package:sqflite/sqflite.dart' as sql;

import '../models/produto.dart';

class ProdutoDao {
  final sql.Database db;

  ProdutoDao(this.db);

  Future<int> insertProduto(Produto produto) async {
    return await db.insert('produto', produto.toMap());
  }

  Future<Produto?> getProdutoPorNome(String nome) async {
    final result = await db.query(
      'produto',
      where: 'nome_produto = ?',
      whereArgs: [nome],
    );
    return result.isNotEmpty ? Produto.fromMap(result.first) : null;
  }

  Future<Produto?> getProdutoPorId(int id) async {
    final result = await db.query(
      'produto',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? Produto.fromMap(result.first) : null;
  }

  Future<List<Produto>> getTodosProdutos() async {
    final result = await db.query('produto');
    return result.map((map) => Produto.fromMap(map)).toList();
  }

  Future<int> updateProduto(Produto produto) async {
    return await db.update(
      'produto',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  Future<int> deleteProduto(int id) async {
    return await db.delete(
      'produto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}