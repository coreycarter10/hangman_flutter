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

  final _onWordChange = StreamController<WordChangeEvent>.broadcast();
  Stream<WordChangeEvent> get onWordChange => _onWordChange.stream;

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

    _broadcastWordChange([HangmanWord.blank]);
    _broadcastWrongGuessesChange();
    _broadcastLetterGuessed();
    _broadcastStatusChange();
  }

  void guessLetter(String letter) {
    _lettersGuessed.add(letter);

    _broadcastLetterGuessed();

    if (_wordToGuess.guessLetter(letter)) {
      _broadcastWordChange([letter]);

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

        _broadcastWordChange(_wordToGuess.revealWord());
        _broadcastStatusChange();
      }
    }
  }

  void _broadcastWordChange(List<String> newCharacters) {
    final event = WordChangeEvent(wordToGuess.wordForDisplay, newCharacters);
    _onWordChange.add(event);
  }

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
  List<String> get wordForDisplay => _wordForDisplay;

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

  List<String> revealWord() {
    final Set<String> missingLetters = {};
    final missingLetterIndexes = toString().allIndexesOf(blank);

    for (int i in missingLetterIndexes) {
      missingLetters.add(word[i]);
    }

    _wordForDisplay = word.split('');

    return missingLetters.toList();
  }

  bool get isWordComplete => !_wordForDisplay.contains(blank);

  @override
  String toString() => wordForDisplay.join();
}

enum GameStatus {
  playing,
  won,
  lost
}

class WordChangeEvent {
  final List<String> word;
  final List<String> newCharacters;

  const WordChangeEvent(this.word, this.newCharacters);

  @override
  String toString() => "Word: ${word.join()}\nNew: $newCharacters";
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