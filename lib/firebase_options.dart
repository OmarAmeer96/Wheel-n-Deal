// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyArW-98_sg8ij6kYDSEbY4raMJWCtTihW4',
    appId: '1:124269518597:web:674ef0b93c01a15c83a16c',
    messagingSenderId: '124269518597',
    projectId: 'wheel-n--deal',
    authDomain: 'wheel-n--deal.firebaseapp.com',
    storageBucket: 'wheel-n--deal.appspot.com',
    measurementId: 'G-TTYS3P38BF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTo_iit1wusOgTUSG7OXPuYIl-0eyuM-E',
    appId: '1:124269518597:android:ebe52e6c6aff001983a16c',
    messagingSenderId: '124269518597',
    projectId: 'wheel-n--deal',
    storageBucket: 'wheel-n--deal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuqNSmNt2OFknR91b8yAXBdGqVE3ojY8g',
    appId: '1:124269518597:ios:c8b0ba1eb7e24ddb83a16c',
    messagingSenderId: '124269518597',
    projectId: 'wheel-n--deal',
    storageBucket: 'wheel-n--deal.appspot.com',
    iosBundleId: 'com.example.wheelNDeal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuqNSmNt2OFknR91b8yAXBdGqVE3ojY8g',
    appId: '1:124269518597:ios:c8b0ba1eb7e24ddb83a16c',
    messagingSenderId: '124269518597',
    projectId: 'wheel-n--deal',
    storageBucket: 'wheel-n--deal.appspot.com',
    iosBundleId: 'com.example.wheelNDeal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArW-98_sg8ij6kYDSEbY4raMJWCtTihW4',
    appId: '1:124269518597:web:4fbf84cac08ac94983a16c',
    messagingSenderId: '124269518597',
    projectId: 'wheel-n--deal',
    authDomain: 'wheel-n--deal.firebaseapp.com',
    storageBucket: 'wheel-n--deal.appspot.com',
    measurementId: 'G-GKSX10CSCC',
  );
}
