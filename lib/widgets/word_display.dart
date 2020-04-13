import 'package:flutter/material.dart';

class WordDisplay extends StatelessWidget {
  final String word;

  const WordDisplay(
      {Key key,
      @required this.word,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      word,
      style: Theme.of(context).textTheme.display1.copyWith(
        letterSpacing: 15,
      ),
    );
  }
}
