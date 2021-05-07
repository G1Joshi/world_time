import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:world_time/views/loading.dart';

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
      home: Loading(),
    );
  }
}
