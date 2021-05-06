import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:world_time/views/home.dart';
import 'package:world_time/views/location.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Time',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/location': (context) => Location(),
      },
    );
  }
}
