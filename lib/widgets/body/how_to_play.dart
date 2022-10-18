import 'package:flutter/material.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/utils/styles.dart';
import 'package:web/widgets/body/how_to_play/how_to_play_part_one.dart';
import 'package:web/widgets/body/how_to_play/how_to_play_part_three.dart';
import 'package:web/widgets/body/how_to_play/how_to_play_part_two.dart';
import 'package:web/widgets/common/animated_widget.dart' as my;

class HowToPlay extends StatefulWidget {
  final ScrollNotifier scrollNotifier;

  const HowToPlay({super.key, required this.scrollNotifier});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay>
    with AutomaticKeepAliveClientMixin {
  final double titleTop = 30.0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox(
      height: 1940.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: titleTop,
            startingPoint: 910.0,
            child: Text('How to play', style: getTitleStyle()),
          ),
          HowToPlayPartOne(scrollNotifier: widget.scrollNotifier),
          HowToPlayPartTwo(scrollNotifier: widget.scrollNotifier),
          HowToPlayPartThree(scrollNotifier: widget.scrollNotifier)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
