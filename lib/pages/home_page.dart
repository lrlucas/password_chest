import 'package:app_password_chest/pages/new_pass_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banco"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListTile(
                title: Text("Facebook"),
                subtitle: Text("correo@gmail.com"),
                trailing: IconButton(
                  tooltip: "Copiar contraseña",
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    print("tap en el boton de copiar");
                  },
                ),
                onTap: () {
                  print("tap en la lista");
                  // CupertinoPageRoute(builder: (_) => NewPassPage());
                  Navigator.pushNamed(context, 'new-pass');
                  // Navigator.of(context).push(NewPassPageRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
