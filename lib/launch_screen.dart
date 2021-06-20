import 'package:flutter/material.dart';
import 'package:shoppylist/model/color_palette.dart';
import 'package:shoppylist/screen/home_screen.dart';
import 'package:shoppylist/screen/nameUser_screen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    super.initState();

      Future.delayed(
        Duration(seconds: 3), 
        () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, gradientOne],
          ),
        ),
        child: Center(
          child: Text(
            'ShoppyList',
            style: TextStyle(fontFamily: 'QuickSand', fontWeight: FontWeight.bold, fontSize: 50, color: backgroundScreenColor, decoration: TextDecoration.none,),
          ),
        ),
      ),
    );
  }
}