import 'package:flutter/material.dart';
import 'package:flutter_app_pms/view/auth/splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS',
      home: SplashScreen(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}