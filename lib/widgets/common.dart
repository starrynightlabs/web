import 'package:flutter/material.dart';

class Part extends StatelessWidget {
  final double currentPixels;
  final bool? isAnimated;

  const Part(this.currentPixels, {Key? key, this.isAnimated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  Widget animateWidget(
    widget, {
    required position,
    required startingPoint,
    margin = 10,
    reverse = false,
    duration = const Duration(milliseconds: 500),
  }) {
    double begin = reverse ? position - margin : position + margin;
    double end = position;

    return AnimatedPositioned(
      curve: Curves.easeOutQuart,
      duration: duration,
      top: currentPixels <= startingPoint ? begin : end,
      child: AnimatedOpacity(
        opacity: currentPixels <= startingPoint ? 0.0 : 1.0,
        duration: duration,
        child: widget,
      ),
    );
  }
}
