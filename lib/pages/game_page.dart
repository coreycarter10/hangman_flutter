import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as engWords;
import 'package:hangman/widgets/word_display.dart';

import '../models/hangman.dart';
import '../utils/screen_util.dart';
import '../widgets/gallows.dart';
import '../widgets/word_display.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  HangmanGame _game;

  @override
  void initState() {
    super.initState();

    final List<String> wordList = engWords.all.where((String word) => word.length > 2 && word.length < 8).map((String word) => word.toUpperCase()).toList();
    _game = HangmanGame(wordList)..newGame();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            StreamBuilder<int>(
              initialData: _game.wrongGuesses,
              stream: _game.onWrongGuessesChange,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Gallows(
                  width: 65.w,
                  height: 45.h,
                  wrongGuesses: snapshot.data,
                );
              }
            ),
            StreamBuilder<String>(
              initialData: _game.wordToGuess.toString(),
              stream: _game.onWordChange,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return WordDisplay(word: snapshot.data);
              }
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _game?.dispose();

    super.dispose();
  }
}
