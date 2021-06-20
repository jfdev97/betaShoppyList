import 'package:flutter/material.dart';

class HexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    
    hexColor = hexColor.toUpperCase().replaceAll("#", "");

    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// Main Color
Color primaryColor = HexColor("A88BEB"); 
Color backgroundScreenColor = HexColor("#EEF2FA");
Color backgroundItemColor = HexColor("#F7F9FE");

// Color Text
Color textPrimaryColor = HexColor("#4D4D4D");
Color textSecondaryColor = HexColor("#A4A4A4");

// Color priority
Color priorityHighColor = HexColor("#08B6F6");
Color priorityMediumColor = HexColor("#E8BC85");
Color priorityLowColor = HexColor("#FF5A5A");

Color gradientOne = HexColor("#A859FF");