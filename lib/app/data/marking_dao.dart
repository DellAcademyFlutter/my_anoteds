import 'package:flutter/cupertino.dart';
import 'package:my_anoteds/app/model/marking.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class MarkingDao {
  /// Insere um [marking] em sua tabela.
  Future insertMarking(Marking marking) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        DbHelper.TABLE_USERS_MARKING,
        marking.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [marking]
  Future<void> updateMarker(Marking marking) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_USERS_MARKING,
      marking.toMap(),
      where: "userId = ? and postitId = ? and markerId = ?",
      whereArgs: [marking.userId, marking.postitId, marking.markerId],
    );
  }

  /// Deleta um [marking]
  Future<void> deleteMarking(Marking marking) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_USERS_MARKING,
      where: "userId = ? and postitId = ? and markerId = ?",
      whereArgs: [marking.userId, marking.postitId, marking.markerId],
    );
  }

  /// Deleta um [marking]
  Future<void> deletePostitMarkers({int userId, int postitId}) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_USERS_MARKING,
      where: "userId = ? and postitId = ?",
      whereArgs: [userId, postitId],
    );
  }

  /// Retorna uma [List] de objetos [marking].
  Future<List<Marking>> getPostitMarkings({int userId, int postitId}) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_USERS_MARKING);

      final userMarking = <Marking>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i]['userId'] == userId &&  maps[i]['postitId'] == postitId) {
          userMarking.add(Marking.fromMap(map: maps[i]));
        }
      }
      return userMarking;
    } catch (ex) {
      return <Marking>[];
    }
  }

  /// Retorna uma [List] de objetos [marking].
  Future<List<int>> getPostitMarkersIds({int userId, int postitId}) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_USERS_MARKING);

      final userMarkingIds = <int>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i]['userId'] == userId &&  maps[i]['postitId'] == postitId) {
          userMarkingIds.add(maps[i]['markerId']);
        }
      }
      return userMarkingIds;
    } catch (ex) {
      return <int>[];
    }
  }
}
