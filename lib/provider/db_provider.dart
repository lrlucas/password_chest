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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Accounts.db');
    print(path);

    // crear db
    return await openDatabase(path, version: 8,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE account(
            id INTEGER PRIMARY KEY,
            title TEXT,
            url TEXT,
            email TEXT,
            password TEXT,
            note TEXT
          )
        ''');
    });
  }

  // crear registro
  Future<int?> newAccount(AccountModel accountModel) async {
    final db = await database;
    final res = await db?.insert('account', accountModel.toJson());
    return res;
  }

  Future<AccountModel?> getAccountById(int id) async {
    final db = await database;
    final res = await db!.query('account', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? AccountModel.fromJson(res.first) : null;
  }

  Future<List<AccountModel>?> getAccounts() async {
    final db = await database;
    final res = await db!.query('account');
    return res.isNotEmpty ? res.map((e) => AccountModel.fromJson(e)).toList() : [];
  }


  Future<int> updateAccount(AccountModel accountModel) async {
    final db = await database;
    final res = await db!.update(
        'account',
        accountModel.toJson(),
        where: 'id = ?',
        whereArgs: [accountModel.id]
    );
    return res;
  }


  Future<int> deleteAccount(int id) async {
    final db = await database;
    final res = db!.delete('account', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllAccounts() async {
    final db = await database;
    final res = db!.delete('account');
    return res;
  }
}
