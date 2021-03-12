import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> locations = [
    WorldTime(url: 'Asia/kolkata', location: 'India', flag: 'india'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'day': instance.day,
    });
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
      body: SafeArea(
        child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      updateTime(index);
                    },
                    title: Text(locations[index].location),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://raw.githubusercontent.com/G1Joshi/Assets/main/Flags/${locations[index].flag}.png'),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
