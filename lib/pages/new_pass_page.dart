import 'package:app_password_chest/models/account_model.dart';
import 'package:app_password_chest/provider/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class NewPassPageRoute extends CupertinoPageRoute {
//   NewPassPageRoute()
//       : super(builder: (BuildContext context) => new NewPassPage());

//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return new FadeTransition(
//       opacity: animation,
//       child: NewPassPage(),
//     );
//   }
// }

class NewPassPage extends StatefulWidget {
  @override
  _NewPassPageState createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  // model
  AccountModel account = AccountModel();
  bool _showPassword = true;
  bool? _disabledSaveButton = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Titulo",
                      ),
                      onChanged: (String value) {
                        if (value.isEmpty) {
                          print('esta vacio la wea');
                          setState(() {
                            this._disabledSaveButton = null;
                            print(this._disabledSaveButton);
                          });
                        }
                        setState(() {
                          account.title = value;
                          this._disabledSaveButton = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        hintText: "Url",
                      ),
                      onChanged: (String value) {
                        setState(() {
                          account.url = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      obscureText: this._showPassword,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        suffixIcon: IconButton(
                          icon: this._showPassword
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye_rounded),
                          onPressed: () {
                            setState(() {
                              this._showPassword = !this._showPassword;
                            });
                          },
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          account.password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Nota",
                      ),
                      onChanged: (String value) {
                        setState(() {
                          account.note = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      child: Text("Save"),
                      onPressed: this._disabledSaveButton != null
                          ? null
                          : () {
                              DBProvider.db.newAccount(this.account);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Save Succesfully'),
                                  action: SnackBarAction(
                                    label: 'Action',
                                    onPressed: () {
                                      // Code to execute.
                                    },
                                  ),
                                ),
                              );
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.of(context).pop();
                            },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
