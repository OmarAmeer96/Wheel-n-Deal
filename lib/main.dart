import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wheel_n_deal/Core/di/dependency_injection.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/simple_bloc_observer.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';
import 'package:wheel_n_deal/constants.dart';
import 'package:wheel_n_deal/firebase_options.dart';
import 'Core/networking/shared_prefs/shared_prefs.dart';

void main() async {
  // Make sure WidgetsBinding is initialized before Firebase (runApp won't do be triggered before them).
  WidgetsFlutterBinding.ensureInitialized();

  // Shared Preferences
  await initSharedPrefsAndGetData();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive Database
  await Hive.initFlutter();
  await registerAdapterAndOpenBox();

  // Bloc Observer
  Bloc.observer = SimpleBlocObserver();

  // Dependency Injection
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: "Wheel n' Deal",
      routerConfig: AppRouter.router,
    );
  }
}

Future<void> registerAdapterAndOpenBox() async {
  // Messaging Local Database
  Hive.registerAdapter(MessageEntityAdapter());
  await Hive.openBox<MessageEntity>(kMessageBox);

  // UserData Local Database
  // Hive.registerAdapter(SignupRequestBodyAdapter());
  // await Hive.openBox<SignupRequestBody>(kUserDataBox);
}

Future<void> initSharedPrefsAndGetData() async {
  await SharedPrefs.cacheintialization();

  // Retrieve Token
  // token = SharedPrefs.getString(key: 'token');
}
