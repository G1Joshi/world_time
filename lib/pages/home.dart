import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
      backgroundColor: Colors.blueGrey[900],
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                icon: Icon(Icons.edit_location),
                label: Text('Edit Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
