import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';
import 'package:web/widgets/common/description_text.dart';
import 'package:web/widgets/common/tag_widget.dart';
import 'dart:async';

import 'package:web/widgets/common/title_text.dart';

class WeMakeStars extends StatefulWidget {
  const WeMakeStars({super.key});

  static const double overallHeight = 715.0;
  static const double titleTop = 72.0;
  static const double imageTop = 160.0;

  @override
  State<WeMakeStars> createState() => _WeMakeStarsState();
}

class _WeMakeStarsState extends State<WeMakeStars>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController _animationController;

  final Map<String, AnimationController> animationControllers = {};
  late final Timer animationTimer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: WeMakeStars.overallHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: WeMakeStars.imageTop,
            child: IntervalAnimatedWidet(
              controller: _animationController,
              beginOffset: const Offset(0.0, 0.1),
              interval: const Interval(0.66, 1),
              child: Image.asset(
                'images/we_make_stars.png',
                height: 555.0,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: WeMakeStars.titleTop,
              ),
              IntervalAnimatedWidet(
                controller: _animationController,
                interval: const Interval(0.0, 0.33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      prefix: 'We Make ',
                      suffix: 'Stars!',
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36.0,
                        height: 1.06,
                        color: Colors.white,
                      ),
                      suffixStyle: TextStyle(
                        color: NyxsColors.mint,
                        shadows: [
                          Shadow(
                            color: NyxsColors.mint.withOpacity(0.8),
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              IntervalAnimatedWidet(
                controller: _animationController,
                interval: const Interval(0.33, 0.66),
                child: DescriptionText(
                  text: 'Support your athletes\nEnjoy the missions together.',
                  style: getDescriptionStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              IntervalAnimatedWidet(
                controller: _animationController,
                beginOffset: const Offset(0.0, 0.6),
                interval: const Interval(0.66, 1),
                child: const TagWidget(tag: 'BETA'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IntervalAnimatedWidet extends StatelessWidget {
  const IntervalAnimatedWidet({
    super.key,
    required this.child,
    required this.controller,
    required this.interval,
    this.beginOffset = const Offset(0.0, 0.4),
  });

  final Widget child;
  final AnimationController controller;
  final Interval interval;
  final Offset beginOffset;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: interval,
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: interval,
          ),
        ),
        child: child,
      ),
    );
  }
}
