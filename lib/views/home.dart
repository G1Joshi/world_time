import 'package:flutter/material.dart';
import 'package:world_time/views/location.dart';

class Home extends StatefulWidget {
  final data;
  Home({@required this.data});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map backColor = {
    'morning': Colors.lightBlue[800],
    'noon': Colors.lightBlue[300],
    'afternoon': Colors.lightBlue[500],
    'evening': Colors.lightBlue[900],
    'night': Colors.lightBlue[900],
  };

  Map textColor = {
    'morning': Colors.blueGrey[100],
    'noon': Colors.blueGrey[800],
    'afternoon': Colors.blueGrey[900],
    'evening': Colors.blueGrey[100],
    'night': Colors.blueGrey[50],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor[widget.data['day']],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('time/${widget.data['day']}.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            Text(
              widget.data['location'].toUpperCase(),
              style: TextStyle(
                color: textColor[widget.data['day']],
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              widget.data['time'],
              style: TextStyle(
                color: textColor[widget.data['day']],
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                letterSpacing: 2.0,
              ),
            ),
            Spacer(flex: 2),
            IconButton(
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Location(),
                    ),
                  );
                });
              },
              icon: Icon(
                Icons.edit_location_rounded,
                size: 60,
                color: textColor[widget.data['day']],
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
