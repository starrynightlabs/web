import 'package:flutter/material.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/widgets/body/how_to_play/how_to_play_title.dart';
import 'package:web/widgets/common/animated_widget.dart' as my;

import 'package:web/utils/styles.dart';
import 'package:web/widgets/body/how_to_play/text_highlighter.dart';

class HowToPlayPartOne extends StatelessWidget {
  const HowToPlayPartOne({Key? key, required this.scrollNotifier})
      : super(key: key);

  final ScrollNotifier scrollNotifier;
  final String howToPlayDescription = '''
Your own athletes from all over
the world and missions given to
the athletes every season.''';
  final double titleTop = 208.0;
  final double descriptionTop = 312.0;
  final double imageTop = 444.0;
  final double decorationTop = 409.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 267.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Image.asset(
              'images/line_1.png',
              color: NyxsColors.mint,
              height: 477.5,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: imageTop,
          startingPoint: 1134.0,
          child: Image.asset(
            'images/mission_cards.png',
            height: 164.0,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: decorationTop,
          startingPoint: 1264.0,
          margin: 30,
          reverse: true,
          duration: const Duration(milliseconds: 1500),
          child: Image.asset(
            'images/decoration_1.png',
            height: 242.0,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: descriptionTop,
          startingPoint: 969.0,
          child: Stack(
            children: [
              const Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 125.0,
                    top: 70.0,
                  ),
                  child: TextHighlighter(width: 123.0),
                ),
              ),
              Positioned(
                child: Text(
                  howToPlayDescription,
                  style: getDescriptionStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: titleTop,
          startingPoint: 933.0,
          child: const HowToPlayTitle(number: 1, title: 'Select'),
        ),
      ],
    );
  }
}
