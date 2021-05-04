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

class NewPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          children: [
            // CupertinoTextField(
            //   placeholder: "Nombre",
            // ),
            // CupertinoTextField(
            //   placeholder: "Contraseña",
            // ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                width: size.width,
                height: size.height * 0.3,
                // color: Colors.grey,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Titulo",
                      ),
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
