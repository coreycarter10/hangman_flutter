import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../models/hangman.dart';
import '../utils/screen_util.dart';

class WordDisplay extends StatelessWidget {
  static const letterSpacing = 24.0;

  final WordChangeEvent event;

  const WordDisplay({
    Key key,
    @required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline4;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: event.word
          .map((String letter) {
            final text = SizedBox(
              width: 14.f,
              child: Text(
                letter,
                style: style,
              ),
            );

            return event.newCharacters.contains(letter)
                ? FadeInUp(
                    key: ObjectKey(text),
                    child: text,
                  )
                : text;
          })
          .toList()
          .joinList(const SizedBox(
            width: letterSpacing,
          )),
    );
  }
}

extension ListUtils on List<Widget> {
  List<Widget> joinList(Widget separator) {
    final Iterator<Widget> iterator = this.iterator;

    final List<Widget> result = [];

    if (!iterator.moveNext()) {
      return result;
    }

    result.add(iterator.current);

    while (iterator.moveNext()) {
      result.add(separator);
      result.add(iterator.current);
    }

    return result;
  }
}
