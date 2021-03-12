import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

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

    return Scaffold(
      backgroundColor: backColor[data['day']],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://raw.githubusercontent.com/G1Joshi/Assets/main/Time/${data['day']}.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/location');
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: textColor[data['day']],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: textColor[data['day']],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        color: textColor[data['day']],
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                    color: textColor[data['day']],
                    fontWeight: FontWeight.bold,
                    fontSize: 60.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
