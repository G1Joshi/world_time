import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late dynamic data = {};

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
    data = ModalRoute.of(context)!.settings.arguments;

    if (data == null) {
      WorldTime instance = WorldTime(location: 'india', gmt: '+05:30');
      instance.getTime();
      data = {
        'location': instance.location,
        'time': instance.time,
        'day': instance.day,
      };
    }

    return Scaffold(
      backgroundColor: backColor[data['day']],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('time/${data['day']}.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            Text(
              data['location'].toUpperCase(),
              style: TextStyle(
                color: textColor[data['day']],
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              data['time'],
              style: TextStyle(
                color: textColor[data['day']],
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                letterSpacing: 2.0,
              ),
            ),
            Spacer(flex: 2),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/location'),
              icon: Icon(
                Icons.edit_location,
                size: 60,
                color: textColor[data['day']],
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
