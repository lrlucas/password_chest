import 'package:app_password_chest/enum/page_mode.dart';
import 'package:app_password_chest/models/argument_model.dart';
import 'package:app_password_chest/service/account_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_password_chest/models/account_model.dart';
import 'package:app_password_chest/provider/db_provider.dart';
import 'package:provider/provider.dart';

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
  // nombre de la ruta como constante en la pagina
  static const routeName = '/new-pass';

  const NewPassPage();

  @override
  _NewPassPageState createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  // model
  AccountModel account = AccountModel();
  bool _showPassword = true;
  bool? _disabledSaveButton;

  // controllers
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _urlController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    if (this.account.title == null) {
      this._disabledSaveButton = true;
    }

    // //
    // final ArgumentModel args =
    // ModalRoute.of(context)!.settings.arguments as ArgumentModel;
    //
    // // this._titleController.text = args.passModel!.title ?? '';
    // this.account.title = args.passModel!.title ?? '';
    // this._titleController.text = this.account.title!;
    // this._titleController.selection = TextSelection.fromPosition(TextPosition(offset: this._titleController.text.length));
    //
    // this._urlController.text = args.passModel!.url ?? '';
    // this._emailController.text = args.passModel!.email ?? '';
    // this._passController.text = args.passModel!.password ?? '';
    // this._noteController.text = args.passModel!.note ?? '';
  }

  @override
  void didChangeDependencies() {

    final ArgumentModel args =
    ModalRoute.of(context)!.settings.arguments as ArgumentModel;
    // print(args.passModel!.id);
    if (args.pageMode == PageMode.save) {
      this.account.id = args.passModel!.id ?? 0;

      // this._titleController.text = args.passModel!.title ?? '';
      this.account.title = args.passModel!.title ?? '';
      this._titleController.text = this.account.title!;
      this._titleController.selection = TextSelection.fromPosition(TextPosition(offset: this._titleController.text.length));

      this.account.url = args.passModel!.url ?? '';
      this.account.email = args.passModel!.email ?? '';
      this.account.password = args.passModel!.password ?? '';
      this.account.note = args.passModel!.note ?? '';
    }


    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    this._titleController.dispose();
    this._urlController.dispose();
    this._emailController.dispose();
    this._passController.dispose();
    this._noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final ArgumentModel args =
    //     ModalRoute.of(context)!.settings.arguments as ArgumentModel;
    final ArgumentModel args =
    ModalRoute.of(context)!.settings.arguments as ArgumentModel;

    switch (args.pageMode) {
      case PageMode.edit:

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Titulo",
                          ),
                          onChanged: (String value) {
                            if (value.isEmpty) {
                              setState(() {
                                this._disabledSaveButton = true;
                              });
                            } else {
                              setState(() {
                                this.account.title = value;
                                this._disabledSaveButton = false;
                              });
                            }
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Correo",
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
                            hintText: "Contrase??a",
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
                          child: Text('Save Edit'),
                          onPressed: this._disabledSaveButton != true ||
                                  this._titleController.text.length > 0
                              ? () {

                                  final newAccount = Provider.of<AccountProvider>(context, listen: false);
                                  newAccount.updateAccount(this.account);


                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Edit Succesfully'),
                                      action: SnackBarAction(
                                        label: 'Action',
                                        onPressed: () {
                                          // Code to execute.
                                        },
                                      ),
                                    ),
                                  );
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Navigator.of(context).pop();
                                }
                              : null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case PageMode.save:
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Titulo",
                          ),
                          onChanged: (String value) {
                            if (value.isEmpty) {
                              setState(() {
                                this._disabledSaveButton = true;
                              });
                            } else {
                              setState(() {
                                account.title = value;
                                this._disabledSaveButton = false;
                              });
                            }
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Correo",
                          ),
                          onChanged: (String value) {
                            setState(() {
                              account.email = value;
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
                            hintText: "Contrase??a",
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
                          child: Text('Save'),
                          onPressed: this._disabledSaveButton != true ||
                                  this._titleController.text.length > 0
                              ? () {
                                  final newAccount = Provider.of<AccountProvider>(context, listen: false);
                                  newAccount.newAccount(this.account);
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
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Navigator.of(context).pop();
                                }
                              : null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      default:
        Container();
    }
    return Container();
  }
}
