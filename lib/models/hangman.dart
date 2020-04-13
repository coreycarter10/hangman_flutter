import 'dart:async';

import 'package:meta/meta.dart';

class HangmanGame {
  static const hanged = 7;

  final List<String> _wordList;
  List<String> get wordList => List<String>.unmodifiable(_wordList);

  final Set<String> _lettersGuessed = {};
  List<String> get lettersGuessed => List<String>.unmodifiable(_lettersGuessed);

  HangmanWord _wordToGuess;
  HangmanWord get wordToGuess => _wordToGuess;

  int _wrongGuesses;
  int get wrongGuesses => _wrongGuesses;

  HangmanGame(List<String> words) : _wordList = words.toList();

  final _onWordChange = StreamController<String>.broadcast();
  Stream<String> get onWordChange => _onWordChange.stream;

  final _onWrongGuessesChange = StreamController<int>.broadcast();
  Stream<int> get onWrongGuessesChange => _onWrongGuessesChange.stream;

  final _onGameOver = StreamController<bool>.broadcast();
  Stream<bool> get onGameOver => _onGameOver.stream;

  void newGame() {
    _wordList.shuffle();
    _wordToGuess = HangmanWord(_wordList.first);
    _wrongGuesses = 0;
    _lettersGuessed.clear();

    _broadcastWordChange();
    _broadcastWrongGuessesChange();
  }

  void guessLetter(String letter) {
    _lettersGuessed.add(letter);

    if (_wordToGuess.guessLetter(letter)) {
      _broadcastWordChange();

      if (_lettersGuessed.length >= _wordToGuess.uniqueLettersCount && _wordToGuess.isWordComplete) {
        _broadcastGameOver(playerWon: true);
      }
    }
    else {
      _wrongGuesses++;
      _broadcastWrongGuessesChange();

      if (isHanged) {
        _broadcastGameOver(playerWon: false);
      }
    }
  }

  void _broadcastWordChange() => _onWordChange.add(wordToGuess.toString());
  void _broadcastWrongGuessesChange() => _onWrongGuessesChange.add(wrongGuesses);
  void _broadcastGameOver({@required bool playerWon}) => _onGameOver.add(playerWon);

  bool get isHanged => _wrongGuesses >= hanged;

  @override
  String toString() {
    return """
Gallows: $wrongGuesses
$wordToGuess
$_lettersGuessed
""";
  }

  void dispose() {
    _onWordChange.close();
    _onWrongGuessesChange.close();
    _onGameOver.close();
  }
}

class HangmanWord {
  static const blank = '_';

  final String word;
  final int uniqueLettersCount;

  List<String> _wordForDisplay;
  String get wordForDisplay => _wordForDisplay.join();

  HangmanWord(this.word) : uniqueLettersCount = word.split('').toSet().length {
    _wordForDisplay = List<String>.filled(word.length, blank);
  }

  bool guessLetter(String letter) {
    final indexes = word.allIndexesOf(letter);

    for (int i in indexes) {
      _wordForDisplay[i] = letter;
    }

    return indexes.isNotEmpty;
  }

  bool get isWordComplete => !_wordForDisplay.contains(blank);

  @override
  String toString() => wordForDisplay;
}

extension StringUtils on String {
  List<int> allIndexesOf(String pattern) {
    final List<int> result = [];

    for (int i = 0; i < this.length; i++) {
      if (this[i] == pattern) {
        result.add(i);
      }
    }

    return result;
  }
}