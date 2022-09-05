import 'package:flutter/material.dart';
import 'package:web/Widgets/common.dart';

class WhatIsNyxs extends Part {
  static const double titleTop = 120.0;
  static const double descriptionTop = 166.0;

  const WhatIsNyxs(
    super.isAnimated,
    super.currentPixels, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String nyxsDescription = '''
A new web3 sporting platform
connecting fans with their
favorite athletes.''';
    Widget title = getTitleText(suffix: 'NYXS');
    Widget description = getDescriptionText(
      nyxsDescription,
      style: getDescriptionStyle(
        color: Colors.white.withOpacity(0.8),
      ),
    );

    return Container(
      height: 360.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          isAnimated
              ? Positioned(top: titleTop, child: title)
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 477.0,
                ),
          isAnimated
              ? Positioned(top: descriptionTop, child: description)
              : animateWidget(
                  description,
                  position: descriptionTop,
                  startingPoint: 518.0,
                ),
        ],
      ),
    );
  }
}
