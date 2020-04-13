import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/theme_switcher.dart';
import '../pages/game_page.dart';
import '../utils/hangman_theme.dart';
import '../utils/screen_util.dart' as su;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (!su.scalerInitialized) {
      su.initializeScaler(context);

      Timer.run(_setTheme);

      return Container();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Hangman',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: Image.asset('assets/images/hangman0.png'),
            ),
            SizedBox(
              width: 20.w,
              height: 10.w,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => GamePage(),
                  ));
                },
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setTheme() =>
      ThemeSwitcher.of(context).switchTheme(generateThemeDate());
}
