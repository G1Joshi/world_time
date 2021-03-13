import 'package:flutter/material.dart';
import 'package:world_time/services/worldtime.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> locations = [
    WorldTime(location: 'africa', gmt: '+02:00'),
    WorldTime(location: 'albania', gmt: '+01:00'),
    WorldTime(location: 'argentina', gmt: '-03:00'),
    WorldTime(location: 'australia', gmt: '+11:00'),
    WorldTime(location: 'bangladesh', gmt: '+06:00'),
    WorldTime(location: 'belgium', gmt: '+01:00'),
    WorldTime(location: 'bosnia', gmt: '+01:00'),
    WorldTime(location: 'brazil', gmt: '-03:00'),
    WorldTime(location: 'cameroon', gmt: '+01:00'),
    WorldTime(location: 'canada', gmt: '-05:00'),
    WorldTime(location: 'chad', gmt: '+01:00'),
    WorldTime(location: 'china', gmt: '+08:00'),
    WorldTime(location: 'croatia', gmt: '+01:00'),
    WorldTime(location: 'czech', gmt: '+01:00'),
    WorldTime(location: 'denmark', gmt: '+01:00'),
    WorldTime(location: 'estonia', gmt: '+02:00'),
    WorldTime(location: 'finland', gmt: '+02:00'),
    WorldTime(location: 'france', gmt: '+01:00'),
    WorldTime(location: 'germany', gmt: '+01:00'),
    WorldTime(location: 'greece', gmt: '+02:00'),
    WorldTime(location: 'hungary', gmt: '+01:00'),
    WorldTime(location: 'india', gmt: '+05:30'),
    WorldTime(location: 'ireland', gmt: '+00:00'),
    WorldTime(location: 'israel', gmt: '+02:00'),
    WorldTime(location: 'italy', gmt: '+01:00'),
    WorldTime(location: 'jamaica', gmt: '-05:00'),
    WorldTime(location: 'korea', gmt: '+09:00'),
    WorldTime(location: 'latvia', gmt: '+02:00'),
    WorldTime(location: 'lithuania', gmt: '+02:00'),
    WorldTime(location: 'luxembourg', gmt: '+01:00'),
    WorldTime(location: 'macedonia', gmt: '+01:00'),
    WorldTime(location: 'netherlands', gmt: '+01:00'),
    WorldTime(location: 'norway', gmt: '+01:00'),
    WorldTime(location: 'poland', gmt: '+01:00'),
    WorldTime(location: 'portugal', gmt: '-01:00'),
    WorldTime(location: 'russia', gmt: '+03:00'),
    WorldTime(location: 'slovakia', gmt: '+01:00'),
    WorldTime(location: 'sweden', gmt: '+01:00'),
    WorldTime(location: 'switzerland', gmt: '+01:00'),
    WorldTime(location: 'turkey', gmt: '+03:00'),
    WorldTime(location: 'uk', gmt: '+00:00'),
    WorldTime(location: 'ukraine', gmt: '+02:00'),
    WorldTime(location: 'usa', gmt: '-05:00'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
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
                    backgroundImage: AssetImage(
                        'assets/flag/${locations[index].location}.png'),
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
