import 'package:app_password_chest/models/account_model.dart';
import 'package:app_password_chest/provider/db_provider.dart';
import 'package:flutter/material.dart';


class AccountProvider extends ChangeNotifier {

  List<AccountModel> accounts = [];


  // AccountProvider() {
  //   this.loadAccounts();
  // }



  newAccount(AccountModel accountModel) async {
    final id = await DBProvider.db.newAccount(accountModel);
    accountModel.id = id;
    this.accounts.add(accountModel);
    notifyListeners();
  }

  updateAccount(AccountModel accountModel) async {
    final res = await DBProvider.db.updateAccount(accountModel);
    notifyListeners();
  }

  loadAccounts() async {
    final accounts = await DBProvider.db.getAccounts();
    this.accounts = [...accounts!];
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllAccounts();
    this.accounts = [];
    notifyListeners();
  }

  deleteAccountById(int id) async {
    await DBProvider.db.deleteAccount(id);
    this.loadAccounts();
  }

}