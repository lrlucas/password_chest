import 'package:flutter/material.dart';
import 'package:app_password_chest/pages/home_page.dart';
import 'package:app_password_chest/pages/new_pass_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => HomePage(),
        'new-pass': (_) => NewPassPage(),
      },
    );
  }
}
