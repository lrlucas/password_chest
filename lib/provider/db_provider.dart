import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:app_password_chest/models/account_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    Directory documentsDiretory = await getApplicationDocumentsDirectory();
    final path = join(documentsDiretory.path, 'Accounts.db');
    print(path);

    // crear db
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE account(
            id INTEGER PRIMARY KEY,
            title TEXT,
            url TEXT,
            password TEXT,
            note TEXT
          )
        ''');
    });
  }

  Future<int?> newAccount(AccountModel accountModel) async {
    final db = await database;
    final res = db?.insert('account', accountModel.toJson());
    return res;
  }
}
