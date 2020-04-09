import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/theme_switcher.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(ThemeSwitcherWidget(
    initialTheme: ThemeData.dark(),
    child: HangmanApp(),
  ));
}

class HangmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      theme: ThemeSwitcher.of(context).themeData,
      home: HomePage(),
    );
  }
}
