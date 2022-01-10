import 'package:flutter/material.dart';

import 'screen_util.dart';

ThemeData generateThemeDate() {
  return ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.copyWith(
      headline6: TextStyle(
        fontFamily: 'VTC',
        fontSize: 25.f,
      ),
      headline4: TextStyle(
        fontFamily: 'VTC',
        fontSize: 18.f,
      ),
      button: TextStyle(
        fontFamily: 'VTC',
        fontSize: 15.f,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  );
}
