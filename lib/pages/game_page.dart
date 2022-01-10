import 'package:english_words/english_words.dart' as eng_words;
import 'package:flutter/material.dart';

import '../models/hangman.dart';
import '../utils/screen_util.dart';
import '../widgets/game_page_widgets.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  HangmanGame _game;

  @override
  void initState() {
    super.initState();

    final List<String> wordList = eng_words.all.where((String word) => word.length > 2 && word.length < 8).map((String word) => word.toUpperCase()).toList();
    _game = HangmanGame(wordList)..newGame();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            StreamBuilder<WordChangeEvent>(
                initialData: WordChangeEvent(_game.wordToGuess.wordForDisplay, [HangmanWord.blank]),
                stream: _game.onWordChange,
                builder: (BuildContext context,
                    AsyncSnapshot<WordChangeEvent> snapshot) {
                  return WordDisplay(event: snapshot.data);
                }
            ),
            StreamBuilder<GameStatus>(
              initialData: _game.status,
              stream: _game.onStatusChange,
              builder: (BuildContext context,
                  AsyncSnapshot<GameStatus> snapshot) {
                switch (snapshot.data) {
                  case GameStatus.playing: return _buildLetterSelection();
                  case GameStatus.lost:
                  case GameStatus.won: return _buildGameOverView(snapshot.data);
                  default: return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
    Widget _buildLetterSelection() {
      return StreamBuilder<List<String>>(
          initialData: _game.lettersGuessed,
          stream: _game.onLetterGuessed,
          builder: (BuildContext context,
              AsyncSnapshot<List<String>> snapshot) {
            return LetterSelection(
              lettersGuessed: snapshot.data,
              onLetterPressed: _game.guessLetter,
            );
          }
      );
    }

    Widget _buildGameOverView(GameStatus status) {
      String msg;
      Color textColor;

      if (status == GameStatus.won) {
        msg = "You win!";
        textColor = Colors.blue;
      }
      else {
        msg = "You lose!";
        textColor = Colors.red;
      }

      return Column(
        children: [
          Text(
            msg,
            style: Theme.of(context).textTheme.headline4.copyWith(
              color: textColor,
            ),
          ),
          SizedBox(height: 2.h),
          TextButton(
            onPressed: () => _game.newGame(),
            child: const Text('Play Again'),
          ),
        ],
      );
    }


  @override
  void dispose() {
    _game?.dispose();

    super.dispose();
  }
}