import 'dart:async';

class HangmanGame {
  static const hanged = 6;

  final List<String> _wordList;
  List<String> get wordList => List<String>.unmodifiable(_wordList);

  final Set<String> _lettersGuessed = {};
  List<String> get lettersGuessed => List<String>.unmodifiable(_lettersGuessed);

  HangmanWord _wordToGuess;
  HangmanWord get wordToGuess => _wordToGuess;

  int _wrongGuesses;
  int get wrongGuesses => _wrongGuesses;

  GameStatus _status;
  GameStatus get status => _status;

  HangmanGame(List<String> words) : _wordList = words.toList();

  final _onWordChange = StreamController<String>.broadcast();
  Stream<String> get onWordChange => _onWordChange.stream;

  final _onLetterGuessed = StreamController<List<String>>.broadcast();
  Stream<List<String>> get onLetterGuessed  => _onLetterGuessed.stream;

  final _onWrongGuessesChange = StreamController<int>.broadcast();
  Stream<int> get onWrongGuessesChange => _onWrongGuessesChange.stream;

  final _onStatusChange = StreamController<GameStatus>.broadcast();
  Stream<GameStatus> get onStatusChange => _onStatusChange.stream;

  void newGame() {
    _wordList.shuffle();
    _wordToGuess = HangmanWord(_wordList.first);
    _wrongGuesses = 0;
    _lettersGuessed.clear();
    _status = GameStatus.playing;

    _broadcastWordChange();
    _broadcastWrongGuessesChange();
    _broadcastLetterGuessed();
    _broadcastStatusChange();
  }

  void guessLetter(String letter) {
    _lettersGuessed.add(letter);

    _broadcastLetterGuessed();

    if (_wordToGuess.guessLetter(letter)) {
      _broadcastWordChange();

      if (_lettersGuessed.length >= _wordToGuess.uniqueLettersCount && _wordToGuess.isWordComplete) {
        _status = GameStatus.won;
        _broadcastStatusChange();
      }
    }
    else {
      _wrongGuesses++;
      _broadcastWrongGuessesChange();

      if (isHanged) {
        _status = GameStatus.lost;
        _wordToGuess.revealWord();

        _broadcastStatusChange();
        _broadcastWordChange();
      }
    }
  }

  void _broadcastWordChange() => _onWordChange.add(wordToGuess.toString());
  void _broadcastLetterGuessed() => _onLetterGuessed.add(lettersGuessed);
  void _broadcastWrongGuessesChange() => _onWrongGuessesChange.add(wrongGuesses);
  void _broadcastStatusChange() => _onStatusChange.add(status);

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
    _onLetterGuessed.close();
    _onWrongGuessesChange.close();
    _onStatusChange.close();
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

  void revealWord() => _wordForDisplay = word.split('');

  bool get isWordComplete => !_wordForDisplay.contains(blank);

  @override
  String toString() => wordForDisplay;
}

enum GameStatus {
  playing,
  won,
  lost
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