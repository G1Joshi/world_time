import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future setData(location, time, day) async {
    await pref.setString("location", location);
    await pref.setString("time", time);
    await pref.setString("day", day);
  }

  static Future getData() async {
    final data = {
      'location': pref.getString("location"),
      'time': pref.getString("time"),
      'day': pref.getString("day"),
    };
    return data["location"] == null ? null : data;
  }

  static Future resetData() async {
    await pref.clear();
  }
}
