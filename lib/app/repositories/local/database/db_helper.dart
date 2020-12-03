import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DATABASE_NAME = "anoteds.db";
  static const TABLE_POSTITS_NAME = "postits";
  static const TABLE_USERS_NAME = "users";
    static const SCRIPT_CREATE_TABLE_POSTITS_SQL =
      "CREATE TABLE IF NOT EXISTS postits (id INTEGER NOT NULL, title TEXT NOT NULL, "
      "description TEXT, color TEXT, userId INTEGER NOT NULL, isPinned	BLOB NOT NULL, "
      "PRIMARY KEY(id AUTOINCREMENT))";
     static const SCRIPT_CREATE_TABLE_USERS_SQL =
      "CREATE TABLE IF NOT EXISTS users (id INTEGER NOT NULL, name TEXT NOT NULL, password TEXT NOT NULL, "
      "email TEXT NOT NULL UNIQUE, birth TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))";

  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(SCRIPT_CREATE_TABLE_POSTITS_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_USERS_SQL);
      },
      version: 1,
    );
  }
}