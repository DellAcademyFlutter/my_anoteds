import 'package:flutter/material.dart';
import 'package:my_anoteds/app/modules/home/postit_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DATABASE_NAME = "anoteds.db";
const TABLE_ANOTEDS_NAME = "anoteds";
const SCRIPT_CRETE_TABLE_ANOTEDS_SQL =
    "CREATE TABLE anoteds(id INTEGER PRIMARY KEY,title TEXT, desc TEXT, tag TEXT)";

class DbHelper{

  Future<Database> _getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), DATABASE_NAME),
    onCreate: (db, version) {
    return db.execute(SCRIPT_CRETE_TABLE_ANOTEDS_SQL);
    },
    version: 1,
    );
  }

  Future create(PostitModel model) async {
    try{
      final db = await _getDatabase();

      await db.insert(
        TABLE_ANOTEDS_NAME,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }catch(ex){
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  Future<List<PostitModel>> getContacts() async {
    try {
      final db = await _getDatabase();
      final maps = await db.query(TABLE_ANOTEDS_NAME);

      return List.generate(
        maps.length,
            (i) {
          return PostitModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return <PostitModel>[];
    }
  }

}