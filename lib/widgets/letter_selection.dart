import 'package:flutter/material.dart';

typedef LetterPressedCallback = void Function(String letter);

class LetterSelection extends StatelessWidget {
  final List<String> lettersGuessed;
  final LetterPressedCallback onLetterPressed;

  const LetterSelection({Key key, @required this.lettersGuessed, @required this.onLetterPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
