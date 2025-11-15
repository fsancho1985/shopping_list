import 'package:sqflite/sqflite.dart' as sql;

import '../models/usuario.dart';

class UsuarioDao {
  final sql.Database db;

  UsuarioDao(this.db);

  Future<int> insertUsuario(Usuario usuario) async {
    return await db.insert('usuario', usuario.toMap());
  }

  Future<Usuario?> getUsuarioPorEmail(String email) async {
    final result = await db.query(
      'usuario',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? Usuario.fromMap(result.first) : null;
  }

  // Future<List<Usuario>> getTodosUsuarios() async {
  //   final result = await db.query('usuario');
  //   return result.map((map) => Usuario.fromMap(map)).toList();
  // }

  Future<int> updateUsuario(Usuario usuario) async {
    return await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<int> deleteUsuario(int id) async {
    return await db.delete(
      'usuario',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}