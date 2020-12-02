import 'package:flutter/material.dart';
import 'package:my_anoteds/app/modules/home/model/postit.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PostitDao {

  /// Referencia ao Banco de Dados
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DbHelper.TABLE_POSTITS_NAME),
      onCreate: (db, version) {
        return db.execute(DbHelper.SCRIPT_CREATE_TABLE_POSTITS_SQL);
      },
      version: 1,
    );
  }

  /// Insere um [Postit] em sua tabela.
  Future insertPostit(Postit postit) async {
    try {
      final db = await _getDatabase();

      await db.insert(
        DbHelper.TABLE_POSTITS_NAME,
        postit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [Postit]
  Future<void> updatePostit(Postit postit) async {
    final db = await _getDatabase();

    await db.update(
      DbHelper.TABLE_POSTITS_NAME,
      postit.toMap(),
      where: "id = ?",
      whereArgs: [postit.id],
    );
  }

  /// Deleta um [Postit]
  Future<void> deletePostit(int id) async {
    final db = await _getDatabase();

    await db.delete(
      DbHelper.TABLE_POSTITS_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [Postit].
  Future<List<Postit>> getPostits() async {
    try {
      final db = await _getDatabase();
      final maps = await db.query(DbHelper.TABLE_POSTITS_NAME);

      return List.generate(
        maps.length,
            (i) {
          return Postit.fromMap(json: maps[i]);
        },
      );
    } catch (ex) {
      return <Postit>[];
    }
  }
}
