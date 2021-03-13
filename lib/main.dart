import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Time',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/location': (context) => Location(),
      },
    );
  }
}
