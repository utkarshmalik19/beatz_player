import 'package:flutter/material.dart';


class AppConstants {
//Colors

  static const Color bgColor = Color(0xff1C1F26);
  static const Color primaryColor = Color(0xffCFF433);
  static const Color textColor = Colors.white;
  static const Color darkBrown = Color(0xff381c14);
  static const Color brown = Color(0xff582c14);
  static const Color orange = Color(0xffeab676);
  static const Color mintGreen = Color(0xff3EB489);

//Gradients

  static const appBarGradient = LinearGradient(colors: [
    Color.fromARGB(255, 29, 201, 192),
    Color.fromARGB(255, 125, 221, 216),
  ]);
  //double height = MediaQuery.of(context).size.height;

  static TextStyle headerTextStyle = const TextStyle(color: textColor,fontSize: 24,fontWeight: FontWeight.bold);
  static TextStyle bigTextStyle = const TextStyle(color: textColor,fontSize: 16,fontWeight: FontWeight.bold);
  static TextStyle smallTextStyle = const TextStyle(color: textColor,fontSize: 14);
}