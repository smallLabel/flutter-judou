import 'package:flutter/material.dart';
import './main_page.dart';
void main() => runApp(MyJuDou());



class MyJuDou extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My JuDou',
      theme: ThemeData(
        primaryColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      home: MainPage(),
    );
  }
}
