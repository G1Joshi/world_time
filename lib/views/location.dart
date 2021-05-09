import 'package:flutter/material.dart';
import 'package:world_time/models/sharedprefs.dart';
import 'package:world_time/services/region.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:world_time/views/home.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  late List<WorldTime> locations = [];

  Future updateTime(index) async {
    WorldTime instance = locations[index];
    instance.getTime();

    await SharedPrefs.setData(instance.location, instance.gmt);

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => updateTime(index),
                    title: Text(
                      locations[index].location.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                          'assets/flag/${locations[index].location}.png'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
