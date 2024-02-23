import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';

void main() async {
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
