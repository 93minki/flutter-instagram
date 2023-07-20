import 'package:flutter/material.dart';

// var _var1; // 다른 파일에서 쓸 수 없는 변수가됨. _변수명 _함수명 _클래스명

var theme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 1,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.red),
      bodyLarge: TextStyle(color: Colors.blue),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
    ));
