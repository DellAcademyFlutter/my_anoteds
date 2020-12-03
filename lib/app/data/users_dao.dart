import 'package:flutter/material.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class UserDao {

  /// Insere um [user] em sua tabela.
  Future insertUser(User user) async {
    try {
      final db = await DbHelper.getDatabase();

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
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_POSTITS_NAME,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  /// Deleta um [loggedUser]
  Future<void> deleteUser(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_USERS_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [loggedUser].
  Future<List<User>> getUsers() async {
    try {
      final db = await DbHelper.getDatabase();
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

  /// Retorna uma [User], se ele estiver na tabela.
  Future<User> getUser({String username, String password}) async {
    final db = await DbHelper.getDatabase();
    final tableName = DbHelper.TABLE_USERS_NAME;
    final result = await db.rawQuery(
        "SELECT * FROM '$tableName' WHERE name = '$username' and password = '$password'");

    if (result.length > 0) {
      return User.fromMap(map: result.first);
    }

    return null;
  }
}
