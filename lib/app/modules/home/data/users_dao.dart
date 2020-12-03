import 'package:flutter/material.dart';
import 'package:my_anoteds/app/modules/home/model/user.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class UserDao {

  /// Referencia ao Banco de Dados
  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DbHelper.DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(DbHelper.SCRIPT_CREATE_TABLE_POSTITS_SQL);
        await db.execute(DbHelper.SCRIPT_CREATE_TABLE_USERS_SQL);
      },
      version: 1,
    );
  }

  /// Insere um [user] em sua tabela.
  Future insertUser(User user) async {
    try {
      final db = await _getDatabase();

      await db.insert(
        DbHelper.TABLE_USERS_NAME,
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [user]
  Future<void> updateUser(User user) async {
    final db = await _getDatabase();

    await db.update(
      DbHelper.TABLE_POSTITS_NAME,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  /// Deleta um [user]
  Future<void> deleteUser(int id) async {
    final db = await _getDatabase();

    await db.delete(
      DbHelper.TABLE_USERS_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [user].
  Future<List<User>> getUsers() async {
    try {
      final db = await _getDatabase();
      final maps = await db.query(DbHelper.TABLE_USERS_NAME);

      return List.generate(
        maps.length,
            (i) {
          return User.fromMap(map: maps[i]);
        },
      );
    } catch (ex) {
      return <User>[];
    }
  }
}
