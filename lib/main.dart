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

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  // Messaging Local Database
  Hive.registerAdapter(MessageEntityAdapter());
  await Hive.openBox<MessageEntity>(kMessageBox);

  // UserData Local Database
  // Hive.registerAdapter(SignupRequestBodyAdapter());
  // await Hive.openBox<SignupRequestBody>(kUserDataBox);

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
