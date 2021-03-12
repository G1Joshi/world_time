import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setWorldTime() async {
    WorldTime instance = WorldTime(
        url: 'Asia/Kolkata', location: 'Kolkata', flag: 'Kolkata.png');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'day': instance.day,
    });
  }

  @override
  void initState() {
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.blueAccent,
          size: 80.0,
        ),
      ),
    );
  }
}
