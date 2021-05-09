import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:world_time/views/home.dart';
import 'package:world_time/models/sharedprefs.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future getDate() async {
    dynamic data;
    await SharedPrefs.init();
    data = await SharedPrefs.getData();
    final instance = WorldTime(location: data['location'], gmt: data['gmt']);
    await instance.getTime();
    data = {
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
