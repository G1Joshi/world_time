import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> locations = [
    WorldTime(url: 'Etc/GMT+2', location: 'africa'),
    WorldTime(url: 'Etc/GMT-3', location: 'argentina'),
    WorldTime(url: 'Etc/GMT+11', location: 'australia'),
    WorldTime(url: 'Etc/GMT+6', location: 'bangladesh'),
    WorldTime(url: 'Etc/GMT-3', location: 'brazil'),
    WorldTime(url: 'Etc/GMT-5', location: 'canada'),
    WorldTime(url: 'Etc/GMT+8', location: 'china'),
    WorldTime(url: 'Etc/GMT+1', location: 'denmark'),
    WorldTime(url: 'Etc/GMT+2', location: 'finland'),
    WorldTime(url: 'Etc/GMT+1', location: 'france'),
    WorldTime(url: 'Etc/GMT+1', location: 'germany'),
    WorldTime(url: 'Etc/GMT+2', location: 'greece'),
    WorldTime(url: 'Asia/kolkata', location: 'india'),
    WorldTime(url: 'Etc/GMT', location: 'ireland'),
    WorldTime(url: 'Etc/GMT+2', location: 'israel'),
    WorldTime(url: 'Etc/GMT+1', location: 'italy'),
    WorldTime(url: 'Etc/GMT+9', location: 'korea'),
    WorldTime(url: 'Etc/GMT+1', location: 'netherlands'),
    WorldTime(url: 'Etc/GMT+1', location: 'norway'),
    WorldTime(url: 'Etc/GMT+1', location: 'poland'),
    WorldTime(url: 'Etc/GMT-1', location: 'portugal'),
    WorldTime(url: 'Etc/GMT+3', location: 'russia'),
    WorldTime(url: 'Etc/GMT+1', location: 'sweden'),
    WorldTime(url: 'Etc/GMT+1', location: 'switzerland'),
    WorldTime(url: 'Etc/GMT+3', location: 'turkey'),
    WorldTime(url: 'Etc/GMT', location: 'uk'),
    WorldTime(url: 'Etc/GMT-5', location: 'usa'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(
      context,
      {
        'location': instance.location,
        'time': instance.time,
        'day': instance.day,
      },
    );
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
                  title: Text(locations[index].location.toUpperCase()),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://raw.githubusercontent.com/G1Joshi/Assets/main/Flags/${locations[index].location}.png'),
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
