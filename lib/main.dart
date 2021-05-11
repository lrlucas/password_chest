import 'package:app_password_chest/service/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_password_chest/pages/home_page.dart';
import 'package:app_password_chest/pages/new_pass_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          HomePage.routeName: (_) => HomePage(),
          NewPassPage.routeName: (_) => NewPassPage(),
        },
      ),
    );
  }
}
