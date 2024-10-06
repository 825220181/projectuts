import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'cart_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoFood ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MenuPage(),
    );
  }
}
