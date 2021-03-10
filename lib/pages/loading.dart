import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading...';
  void setWorldTime() async {
    WorldTime instance = WorldTime(
        url: 'Asia/Kolkata', location: 'Kolkata', flag: 'Kolkata.png');
    await instance.getTime();
    setState(() {
      time = instance.time;
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
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Loading'),
      ),
      body: SafeArea(
        child: Text(time),
      ),
    );
  }
}
