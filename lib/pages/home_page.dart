import 'dart:async';

import 'package:flutter/material.dart';

import '../pages/game_page.dart';
import '../utils/hangman_theme.dart';
import '../utils/screen_util.dart' as su;
import '../widgets/theme_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

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
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: Image.asset('assets/images/hangman0.png'),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 5.h,
              ),
              child: TextButton(
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
