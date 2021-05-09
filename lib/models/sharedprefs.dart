import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future setData(location, gmt) async {
    await pref.setString('location', location);
    await pref.setString('gmt', gmt);
  }

  static Future getData() async {
    final data = {
      'location': pref.getString('location') ?? 'india',
      'gmt': pref.getString('gmt') ?? '+05:30',
    };
    return data;
  }

  static Future resetData() async {
    await pref.clear();
  }
}
