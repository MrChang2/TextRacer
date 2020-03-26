import 'package:flutter/material.dart';
import 'menu.dart';

void main() => runApp(MyApp());

//Class: MyApp
//Purpose: set up app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Racer',
      home: Menu()
    );
  }
}