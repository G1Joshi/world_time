import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments;

    if (data == null) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: Center(
          child: SpinKitPouringHourglass(
            color: Colors.blueAccent,
            size: 80.0,
          ),
        ),
      );
    } else {
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://raw.githubusercontent.com/G1Joshi/Assets/main/Time/${data['day']}.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 50),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <SizedBox>[
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  data['location'].toUpperCase(),
                  style: TextStyle(
                    color: textColor[data['day']],
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    letterSpacing: 2.0,
                  ),
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
                SizedBox(
                  height: 50.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit_location_rounded,
                    size: 50,
                    color: textColor[data['day']],
                  ),
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(
                        () {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'day': result['day'],
                            'flag': result['flag']
                          };
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
