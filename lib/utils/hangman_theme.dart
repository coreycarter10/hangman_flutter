import 'package:flutter/material.dart';

import 'screen_util.dart';

ThemeData generateThemeDate() {
  return ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'VTC',
            fontSize: 25.f,
          ),
          display1: TextStyle(
            fontFamily: 'VTC',
            fontSize: 18.f,
          ),
          button: TextStyle(
            fontFamily: 'VTC',
            fontSize: 3.h,
          ),
        ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  );
}
