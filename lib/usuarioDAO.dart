import 'package:flutter_app/helper.dart';
import 'package:flutter_app/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDAO {
  Future<List<Usuario>> get() async {
    Database db = await DBHelper().database;

    final List<Map<String, dynamic>> maps = await db.query('usuario');
    var usuario = List.generate(maps.length, (i) {
      return Usuario.fromJson(maps[i]);
    });
    return usuario;
  }

  Future<void> insert({Usuario usuario}) async {
    Database db = await DBHelper().database;

    await db.insert('usuario', usuario.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Usuario usuario) async {
    Database db = await DBHelper().database;

    await db.update('usuario', usuario.toJson(),
        where: "id = ?", whereArgs: [usuario.id]);
  }

  Future<void> delete(int id) async {
    Database db = await DBHelper().database;

    await db.delete('usuario', where: "id = ?", whereArgs: [id]);
  }
}
