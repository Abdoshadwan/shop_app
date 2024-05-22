import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/colors.dart';

ThemeData lighttheme = ThemeData(
    primarySwatch: primary_c,
     fontFamily: 'oswald',
     appBarTheme: appbarthem);

ThemeData darktheme = ThemeData();

AppBarTheme appbarthem = AppBarTheme(
  elevation: 0.0,
  backgroundColor: Colors.white,
  systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, statusBarColor: Colors.white),
);
