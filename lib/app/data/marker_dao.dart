import 'package:flutter/cupertino.dart';
import 'package:my_anoteds/app/model/marker.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class MarkerDao {
  /// Insere um [marker] em sua tabela.
  Future<int> insertMarker(Marker marker) async {
    try {
      final db = await DbHelper.getDatabase();
      int generatedId;

      await db
          .insert(
            DbHelper.TABLE_USERS_MARKER,
            marker.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          )
          .then((value) => generatedId = value);

      return generatedId;
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [marker]
  Future<void> updateMarker(Marker marker) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_USERS_MARKER,
      marker.toMap(),
      where: "id = ?",
      whereArgs: [marker.id],
    );
  }

  /// Deleta um [marker]
  Future<void> deleteMarker(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_USERS_MARKER,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [marker].
  Future<List<Marker>> getMarkers(int userId) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_USERS_MARKER);

      final userMarkers = <Marker>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i]['userId'] == userId) {
          userMarkers.add(Marker.fromMap(map: maps[i]));
        }
      }
      return userMarkers;
    } catch (ex) {
      return <Marker>[];
    }
  }
}
