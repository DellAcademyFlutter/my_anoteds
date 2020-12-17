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

  /// Retorna uma [User], se ele estiver na tabela.
  Future<User> getUser({String username, String password}) async {
    final db = await DbHelper.getDatabase();
    final tableName = DbHelper.TABLE_USERS_NAME;
    final result = await db.rawQuery(
        "SELECT * FROM '$tableName' WHERE name = '$username' and password = '$password'");
    if (result.isNotEmpty) {
      return User.fromMap(map: result.first);
    }

    return null;
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

  /// Insere um [user] em sua tabela.
  Future insertLoggedUser(String name) async {
    try {
      final db = await DbHelper.getDatabase();
      final data = <String, dynamic>{};
      data['loggedUserId'] = name;

      await db.insert(DbHelper.TABLE_USERS_CONFIGS, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Deleta um [loggedUser]
  Future<void> deleteLoggedUser(String name) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_USERS_CONFIGS,
      where: "loggedUserId = ?",
      whereArgs: [name],
    );
  }

  /// Retorna uma [User], se ele estiver na tabela de usuario logado.
  Future<User> getLoggedUser() async {
    final db = await DbHelper.getDatabase();
    final tableName = DbHelper.TABLE_USERS_CONFIGS;
    final tableName2 = DbHelper.TABLE_USERS_NAME;
    final result = await db.rawQuery("SELECT * FROM '$tableName'");

    if (result.isNotEmpty) {
      final map = (result.first);
      final String username = map['loggedUserId'];

      final result2 = await db
          .rawQuery("SELECT * FROM '$tableName2' WHERE name = '$username'");
      return User.fromMap(map: result2.first);
    }

    return null;
  }
}
