import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../models/hangman.dart';

class WordDisplay extends StatefulWidget {
  final WordChangeEvent event;

  const WordDisplay({Key key, @required this.event,}) : super(key: key);

  @override
  _WordDisplayState createState() => _WordDisplayState();
}

class _WordDisplayState extends State<WordDisplay> {
  static const letterSpacing = 15.0;

  AnimationController _animateController;

  @override
  Widget build_old(BuildContext context) {

    if (_animateController != null && !_animateController.isAnimating) {
      _animateController?.reset();
      _animateController?.forward();
    }

    return FadeInUp(
      manualTrigger: true,
      controller: (AnimationController ctrl) {
        _animateController = ctrl;
        _animateController?.forward();
      },
      child: Text(
        widget.event.word.join(),
        style: Theme.of(context).textTheme.display1.copyWith(
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.display1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.event.word.map((String letter) {
        final text = Text(
          letter,
          style: style,
        );

        return widget.event.newCharacters.contains(letter) ? FadeInUp(child: text) : text;
      }).toList().joinList(SizedBox(width: letterSpacing,)),
    );
  }
}

extension ListUtils on List {
  List<Widget> joinList(Widget separator) {
    final Iterator<Widget> iterator = this.iterator;

    final List<Widget> result = [];

    if (!iterator.moveNext()) return result;

    result.add(iterator.current);

    while (iterator.moveNext()) {
      result.add(separator);
      result.add(iterator.current);
    }

    return result;
  }
}