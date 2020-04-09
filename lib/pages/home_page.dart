import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/theme_switcher.dart';
import '../utils/hangman_theme.dart';
import '../utils/screen_util.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (!scalerInitialized) {
      initializeScaler(context);

      Timer.run(_setTheme);

      return Container();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Hangman',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              width: 20.w,
              height: 10.w,
              child: RaisedButton(
                child: Text("Start"),
                onPressed: () => null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setTheme() => ThemeSwitcher.of(context).switchTheme(generateThemeDate());
}
