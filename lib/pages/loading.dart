import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
      backgroundColor: Colors.blueGrey[900],
        title: Text('Loading'),
      ),
      body: SafeArea(
        child: Text('Loading'),
      ),
    );
  }
}
