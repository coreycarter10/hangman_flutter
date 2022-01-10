import 'package:flutter/material.dart';

import '../utils/screen_util.dart';

typedef LetterPressedCallback = void Function(String letter);

class LetterSelection extends StatelessWidget {
  static final alphabet = generateAlphabet();

  final List<String> lettersGuessed;
  final LetterPressedCallback onLetterPressed;

  const LetterSelection({Key key, @required this.lettersGuessed, @required this.onLetterPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 800,
      ),
      child: Wrap(
        children: alphabet.map((String letter) {
          return SizedBox(
            width: 11.w,
            child: TextButton(
              onPressed: lettersGuessed.contains(letter) ? null : () => onLetterPressed(letter),
              child: Text(letter),
                ),
          );
            }).toList(),
      ),
    );
  }

  static List<String> generateAlphabet() {
    final startingCharCode = 'A'.codeUnits.first;

    final charCodes =  List<int>.generate(26, (int index) => startingCharCode + index);

    return List.unmodifiable(charCodes.map((int code) => String.fromCharCode(code)));
  }
}
