import 'package:flutter/material.dart';
import 'package:shoppylist/model/color_palette.dart';
import 'package:shoppylist/screen/home_screen.dart';

class NameUserScreen extends StatefulWidget {
  @override
  _NameUserScreenState createState() => _NameUserScreenState();
}

class _NameUserScreenState extends State<NameUserScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: backgroundScreenColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3, 
                        blurRadius: 8,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, letterSpacing: 0.3, color: Colors.black,),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0, 
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 50.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    child: Center(
                      child: Text(
                        'Go To List',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    onTap: () {
                      
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}