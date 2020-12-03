import 'package:flutter/material.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PostitDao {

  /// Insere um [Postit] em sua tabela.
  Future insertPostit(Postit postit) async {
    try {
      final db = await DbHelper.getDatabase();

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
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_POSTITS_NAME,
      postit.toMap(),
      where: "id = ?",
      whereArgs: [postit.id],
    );
  }

  /// Deleta um [Postit]
  Future<void> deletePostit(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_POSTITS_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [Postit].
  Future<List<Postit>> getPostits(int userId) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_POSTITS_NAME);

      final List<Postit> userPostits = List();

    for(int i=0; i<maps.length; i++){
      if(maps[i]['userId'] == userId){
        userPostits.add(Postit.fromMap(map: maps[i]));
      }
    }
    
    return userPostits;

    } catch (ex) {
      return <Postit>[];
    }
  }
}
