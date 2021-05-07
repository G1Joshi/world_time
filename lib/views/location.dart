import 'package:flutter/material.dart';
import 'package:world_time/services/region.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:world_time/views/home.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  late List<WorldTime> locations = [];

  void updateTime(index) {
    WorldTime instance = locations[index];
    instance.getTime();
    final data = {
      'location': instance.location,
      'time': instance.time,
      'day': instance.day,
    };
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(data: data),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    locations = Region.locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Choose Location'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => updateTime(index),
                    title: Text(locations[index].location.toUpperCase()),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('flag/${locations[index].location}.png'),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
