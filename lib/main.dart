import 'package:flutter/material.dart';
import 'package:shoppylist/screen/feedback_screen.dart';
import 'package:shoppylist/screen/home_screen.dart';
import 'package:shoppylist/launch_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LaunchScreen(),
    );
  }
}
