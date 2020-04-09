import 'package:flutter/material.dart';

import 'screen_util.dart';

ThemeData generateThemeDate() {
  return ThemeData.dark().copyWith(
    textTheme: TextTheme(
      title: TextStyle(
        fontFamily: 'VTC',
        fontSize: 25.f,
      ),
    ),
  );
}