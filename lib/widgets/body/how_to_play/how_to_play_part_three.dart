import 'package:flutter/material.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/utils/styles.dart';
import 'package:web/widgets/body/how_to_play/how_to_play_title.dart';
import 'package:web/widgets/body/how_to_play/text_highlighter.dart';
import 'package:web/widgets/common/animated_widget.dart' as my;

class HowToPlayPartThree extends StatelessWidget {
  final ScrollNotifier scrollNotifier;
  const HowToPlayPartThree({Key? key, required this.scrollNotifier})
      : super(key: key);

  final double titleTop = 1341.0;
  final double descriptionTop = 1445.0;
  final double imageTop = 1577.0;
  final double decorationTop = 1513.0;
  final String howToPlayDescription = '''
Together when your athletes
complete the missions and
earn the rewards from NYXS.''';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 1405.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset(
              'images/line_3.png',
              color: NyxsColors.mint,
              height: 431.51,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: imageTop,
          startingPoint: 2259.0,
          child: Image.asset(
            'images/mission_complete_card.png',
            height: 130.0,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: descriptionTop,
          startingPoint: 2133.0,
          child: Stack(
            children: [
              const Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 73.0,
                    top: 70.0,
                  ),
                  child: TextHighlighter(width: 173.0),
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
          startingPoint: 2097.0,
          child: const HowToPlayTitle(number: 3, title: 'Celebrate'),
        ),
        my.AnimatedWidget(
          scrollNotifier: scrollNotifier,
          position: decorationTop,
          startingPoint: 2389.0,
          margin: 30,
          reverse: true,
          duration: const Duration(milliseconds: 1500),
          child: Image.asset(
            'images/decoration_3.png',
            height: 276.24,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }
}
