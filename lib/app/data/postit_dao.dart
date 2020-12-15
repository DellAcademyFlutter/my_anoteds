import 'package:flutter/material.dart';
import 'package:my_anoteds/app/model/postit.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PostitDao {
  /// Insere um [Postit] em sua tabela.
  Future<int> insertPostit(Postit postit) async {
    try {
      final db = await DbHelper.getDatabase();
      int generatedId;

      await db
          .insert(
            DbHelper.TABLE_POSTITS_NAME,
            postit.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          )
          .then((value) => generatedId = value);

      return generatedId;
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

  /// Retorna uma [List] de objetos [Postit] do usuario de id [userId].
  Future<List<Postit>> getPostits({int userId}) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_POSTITS_NAME);

      final userPostits = <Postit>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i]['userId'] == userId) {
          userPostits.add(Postit.fromMap(map: maps[i]));
        }
      }
      return userPostits;
    } catch (ex) {
      //print(ex);
      return <Postit>[];
    }
  }

  /// Retorna uma [List] de [Postit]s do usuario de id [userId] filtrado por uma lita de marcadores.
  Future<List<Postit>> getMarkedPostits({int userId, List<int> markersId}) async {
    try {
      final db = await DbHelper.getDatabase();
      final postitMaps = await db.query(DbHelper.TABLE_POSTITS_NAME);

      final userPostits = <Postit>[];

      // Filtra postit por usuario
      for (var i = 0; i < postitMaps.length; i++) {
        if (postitMaps[i]['userId'] == userId) {

          // Filtra postit por marcadores
          final markingMaps = await db.rawQuery("SELECT * FROM ${DbHelper.TABLE_USERS_MARKING} WHERE postitId = ${postitMaps[i]['id']}");
          var countTags = 0;
          for (var j = 0; j < markingMaps.length; j++){
            if(markersId.contains(markingMaps[j]['markerId'])) countTags++;
          }
          if (countTags == markersId.length){
            userPostits.add(Postit.fromMap(map: postitMaps[i]));
          }
        }
      }
      return userPostits;
    } catch (ex) {
      //print(ex);
      return <Postit>[];
    }
  }
}
