import 'package:flutter/material.dart';

class Themes {
  static const first = Color.fromRGBO(1, 42, 74, 1);
  static const second = Color.fromRGBO(1, 58, 99, 1);
  static const third = Color.fromRGBO(1, 79, 134, 1);
  static const fourth = Color.fromRGBO(70, 143, 175, 1);
  static const fifth = Color.fromRGBO(169, 214, 229, 1);
  static const white = Color.fromARGB(255, 233, 232, 232);
  static const appBar = Color.fromRGBO(97, 165, 194, 1);

  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: first,
    colorScheme: const ColorScheme.dark(primary: first),
    dividerColor: Colors.white,
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: first,
    colorScheme: ColorScheme.light(primary: first),
    dividerColor: Colors.black,
  );
}


/*static const first = Color.fromRGBO(107, 144, 128, 1);
  static const second = Color.fromRGBO(164, 195, 178, 1);
  static const third = Color.fromRGBO(204, 227, 222, 1);
  static const fourth = Color.fromRGBO(234, 244, 244, 1);
  static const fifth = Color.fromRGBO(246, 255, 248, 1);*/