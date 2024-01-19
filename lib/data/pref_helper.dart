import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  final Future<SharedPreferences> sharedPref;

  PrefHelper({required this.sharedPref});

  static const darkTheme = 'DARK_THEME';
  static const dailyNews = 'DAILY_NEWS';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPref;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPref;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPref;
    return prefs.getBool(dailyNews) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPref;
    prefs.setBool(dailyNews, value);
  }
}
