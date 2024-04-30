import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences sharedPreferences;
  static cacheintialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

// Handling Stings
  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return await sharedPreferences.setString(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences.getString(key);
  }

// Handling Booleans
  static Future<bool> setBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences.getBool(key);
  }

// Handling Integers
  static Future<bool> setInt({
    required String key,
    required int value,
  }) async {
    return await sharedPreferences.setInt(key, value);
  }

  static int? getInt({required String key}) {
    return sharedPreferences.getInt(key);
  }

// Handling Doubles
  static Future<bool> setDouble({
    required String key,
    required double value,
  }) async {
    return await sharedPreferences.setDouble(key, value);
  }

  static double? getDouble({required String key}) {
    return sharedPreferences.getDouble(key);
  }

// Handling Lists
  static Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return await sharedPreferences.setStringList(key, value);
  }

  static List<String>? getStringList({required String key}) {
    return sharedPreferences.getStringList(key);
  }

// Removing Data
  static Future<bool> remove({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
