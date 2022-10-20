import 'package:flutter/material.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/widgets/common/description_text.dart';
import 'package:web/widgets/common/title_text.dart';
import 'package:web/widgets/common/animated_widget.dart' as my;

class WhatIsMission extends StatefulWidget {
  final ScrollNotifier scrollNotifier;
  const WhatIsMission({
    Key? key,
    required this.scrollNotifier,
  }) : super(key: key);

  final double titleTop = 120.0;
  final double descriptionTop = 166.0;
  final double titleTwoTop = 402.0;
  final double descriptionTwoTop = 448.0;
  final double imageTop = 540.0;
  final String missionDescription = '''
The mission is the next level goal
for the athletes to achieve the dream,
which is an important opportunity
for fans and athletes to join together
and watch players to grow.''';
  final String starDescription = '''
As a utility token, Stars are swapped
from NYXS(Governance token)''';

  @override
  State<WhatIsMission> createState() => _WhatIsMissionState();
}

class _WhatIsMissionState extends State<WhatIsMission>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black.withOpacity(0.8),
      // TODO: revert to 702.0
      height: 430.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.titleTop,
            startingPoint: 2701.0,
            child: const TitleText(suffix: 'Mission'),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.descriptionTop,
            startingPoint: 2731.0,
            child: DescriptionText(
              text: widget.missionDescription,
            ),
          ),
          /*
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.titleTwoTop,
            startingPoint: 2957.0,
            child: const TitleText(suffix: "Star"),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.descriptionTwoTop,
            startingPoint: 2987.0,
            child: DescriptionText(text: widget.starDescription),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.imageTop,
            startingPoint: 3141.0,
            child: Image.asset(
              'images/star.png',
              width: 128.0,
              height: 126.0,
              filterQuality: FilterQuality.high,
            ),
          ),
          */
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
