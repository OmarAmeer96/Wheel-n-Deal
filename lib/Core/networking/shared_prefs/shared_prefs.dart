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

// Copilot's Code to Save Orders Data in Shared Preferences
/*
import 'dart:convert';

class Order {
  final String id;
  final String name;
  final int quantity;
  final bool isCompleted;

  Order({
    required this.id,
    required this.name,
    required this.quantity,
    required this.isCompleted,
  });

  // Convert an order to a JSON string
  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'quantity': quantity,
      'isCompleted': isCompleted,
    });
  }

  // Convert a JSON string to an order
  static Order fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Order(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      isCompleted: json['isCompleted'],
    );
  }
}
*/

/*
// Save a list of orders
static Future<bool> saveOrders(List<Order> orders) async {
  List<String> orderStrings = orders.map((order) => order.toJson()).toList();
  return await setStringList(key: 'orders', value: orderStrings);
}

// Load the list of orders
static Future<List<Order>> loadOrders() {
  List<String>? orderStrings = getStringList(key: 'orders');
  if (orderStrings == null) {
    return Future.value([]);
  } else {
    return Future.value(orderStrings.map((s) => Order.fromJson(s)).toList());
  }
}
*/