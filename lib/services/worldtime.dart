import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String url;
  String location;
  String flag;
  String time = 'loading...';
  late String day;

  WorldTime({required this.url, required this.location, required this.flag});

  Future<void> getTime() async {
    try {
      var api = Uri.https(
          'www.worldtimeapi.org', '/api/timezone/$url', {'q': '{https}'});
      Response response = await get(api);
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String hours = data['utc_offset'].substring(1, 3);
      String minutes = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime)
          .add(Duration(hours: int.parse(hours)))
          .add(Duration(minutes: int.parse(minutes)));
      if (now.hour >= 4 && now.hour < 10)
        day = 'morning';
      else if (now.hour >= 10 && now.hour < 13)
        day = 'noon';
      else if (now.hour >= 13 && now.hour < 16)
        day = 'afternoon';
      else if (now.hour >= 16 && now.hour < 22)
        day = 'evening';
      else
        day = 'night';

      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Not Found!';
    }
  }
}
