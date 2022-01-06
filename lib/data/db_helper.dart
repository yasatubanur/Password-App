import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;

  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "password.db");
    var passwordDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return passwordDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table passwordInfo(id integer primary key, passName text, username text, password text)");
  }
}
