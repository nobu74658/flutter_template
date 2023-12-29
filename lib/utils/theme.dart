import 'package:flutter/material.dart';

ThemeData getAppTheme() => ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      fontFamily: 'Regular',
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 20,
        ),
      ),
    );
