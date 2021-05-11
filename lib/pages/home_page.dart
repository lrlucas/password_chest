import 'package:app_password_chest/enum/page_mode.dart';
import 'package:app_password_chest/models/account_model.dart';
import 'package:app_password_chest/models/argument_model.dart';
import 'package:app_password_chest/models/pass_model.dart';
import 'package:app_password_chest/pages/new_pass_page.dart';
import 'package:app_password_chest/provider/db_provider.dart';
import 'package:app_password_chest/service/account_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final accountList = Provider.of<AccountProvider>(context); // TODO: listen en false para que no se redibuje el widget
    final accounts = accountList.accounts;
    return Scaffold(
      appBar: AppBar(
        title: Text("Banco"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                NewPassPage.routeName,
                arguments: ArgumentModel(
                  pageMode: PageMode.save,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: accounts.length,
          itemBuilder: ( _, i ) => ListTile(
                  key: Key(i.toString()),
                  title: Text(accounts[i].title ?? 'no title'),
                  subtitle: Text(accounts[i].email ?? 'no mail'),
                  trailing: IconButton(
                    tooltip: "Copiar contraseña",
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      print("tap en el boton de copiar");
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NewPassPage.routeName,
                      arguments: ArgumentModel(
                        pageMode: PageMode.edit,
                        passModel:
                            new PassModel(
                              id: accounts[i].id!,
                              title:  accounts[i].title!,
                              email:  accounts[i].email!,
                              url:  accounts[i].url!,
                              note:  accounts[i].note!,
                              password:  accounts[i].password!
                            )
                      ),
                    );
                  },
                ),
        ),

        // child: SingleChildScrollView(
        //   physics: BouncingScrollPhysics(),
        //   child: Column(
        //     children: [
        //       ListTile(
        //         title: Text("Facebook"),
        //         subtitle: Text("correo@gmail.com"),
        //         trailing: IconButton(
        //           tooltip: "Copiar contraseña",
        //           icon: Icon(Icons.copy),
        //           onPressed: () {
        //             print("tap en el boton de copiar");
        //           },
        //         ),
        //         onTap: () {
        //           Navigator.pushNamed(
        //             context,
        //             NewPassPage.routeName,
        //             arguments: ArgumentModel(
        //               pageMode: PageMode.edit,
        //               passModel:
        //                   new PassModel(1, 'Facebook', 'correo@gmail.com'),
        //             ),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
