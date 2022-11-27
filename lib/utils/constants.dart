import 'package:flutter/material.dart';

class AppConstants {
  static const baseUrl = "http://complain-app.herokuapp.com";
  static List<String> complainLevels = [
    "Low",
    "Moderate",
    "Important",
    "Critical"
  ];
  // get(){
  //   complainLevels.indexOf(element)
  // }
  static const accessToken = 'access_token';
  static const List<Color> icons = [Colors.blue,Colors.yellow,Colors.green, Colors.red];
}
