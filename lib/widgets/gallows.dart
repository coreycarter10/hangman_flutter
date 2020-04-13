import 'package:flutter/material.dart';

class Gallows extends StatelessWidget {
  static const imagePath = 'assets/images';

  final int wrongGuesses;
  final double width;
  final double height;

  const Gallows(
      {Key key,
      @required this.wrongGuesses,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('$imagePath/hangman$wrongGuesses.png'),
    );
  }
}
