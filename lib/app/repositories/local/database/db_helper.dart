import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DATABASE_NAME = "anoteds.db";
  static const TABLE_POSTITS_NAME = "postits3";
  static const SCRIPT_CREATE_TABLE_POSTITS_SQL =
      "CREATE TABLE IF NOT EXISTS postits3 (id INTEGER NOT NULL, title TEXT NOT NULL, description TEXT, color TEXT, user_id INTEGER NOT NULL, is_pinned	BLOB NOT NULL, PRIMARY KEY(id AUTOINCREMENT))";


  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(SCRIPT_CREATE_TABLE_POSTITS_SQL);
      },
      version: 1,
    );
  }
}