import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String url;
  String location;
  String flag;
  String time = 'loading...';

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
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Not Found!';
    }
  }
}
