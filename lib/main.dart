import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:movie_app/screens/Home.dart';
import 'package:movie_app/constants/Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorBase.primary,
        scaffoldBackgroundColor: ColorBase.primary,
      ),
      home: Home(),
    );
  }
}