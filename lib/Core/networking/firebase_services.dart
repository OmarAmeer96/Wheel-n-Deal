import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title: ${message.notification?.title}');
  log('Body: ${message.notification?.body}');
  log('Payload: ${message.data}');
  // log('Handling a background message ${message.messageId}');
}

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final FCMToken = await _firebaseMessaging.getToken();
    log('$FCMToken \n---', name: 'Firebase Messaging Token');

    final userToken = SharedPrefs.getString(key: kToken);
    log('$userToken', name: 'kToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
