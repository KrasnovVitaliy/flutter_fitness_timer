import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Config {
  Future<String> getConfig(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.getString(key);
  }

  Future<void> setConfig(String key, String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(key, value);
  }
}

const String isDarkThemeKey = 'isDarkTheme';
