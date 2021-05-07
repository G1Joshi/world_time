import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:world_time/views/home.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future getDate() async {
    final instance = WorldTime(location: 'india', gmt: '+05:30');
    await instance.getTime();
    final data = {
      'location': instance.location,
      'time': instance.time,
      'day': instance.day,
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Home(data: snapshot.data),
              ),
            );
          });
        }
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey[900],
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
