import 'package:flutter/material.dart';

ThemeData LightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
         
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black)),
    brightness: Brightness.light);

ThemeData DarkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff15161a),
  appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff15161a),
        elevation: 0,),
  brightness: Brightness.dark);
