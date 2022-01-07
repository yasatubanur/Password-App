import 'dart:async';

import 'package:password_app/models/pass_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;

  Future<Database> get db async {
    _db = await initializeDb();
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

  Future<List<PassInfo>> getPassInfos() async {
    Database db = await this.db;
    var result = await db.query("passwordInfo");
    return List.generate(result.length, (i) {
      return PassInfo.fromObject(result[i]);
    });
  }

  Future<int> insert(PassInfo passInfo) async {
    Database db = await this.db;
    var result = await db.insert("passwordInfo", passInfo.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from passwordInfo where id = $id");
    return result;
  }

  Future<int> update(PassInfo passInfo) async {
    Database db = await this.db;
    var result = await db.update("passwordInfo", passInfo.toMap(),
        where: "id=?", whereArgs: [passInfo.id]);
    return result;
  }
}
