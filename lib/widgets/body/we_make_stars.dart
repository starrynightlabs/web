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
            child: animateWeMakeStars(
              Image.asset(
                'images/we_make_stars.png',
                height: 555.0,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
              ),
              _animationController,
              beginOffset: const Offset(0.0, 0.1),
              const Interval(0.66, 1),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: WeMakeStars.titleTop,
              ),
              animateWeMakeStars(
                Row(
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
                _animationController,
                const Interval(0.0, 0.33),
              ),
              const SizedBox(
                height: 24,
              ),
              animateWeMakeStars(
                DescriptionText(
                  text: 'Support your athletes\nEnjoy the missions together.',
                  style: getDescriptionStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                _animationController,
                const Interval(0.33, 0.66),
              ),
              const SizedBox(
                height: 24,
              ),
              animateWeMakeStars(
                const TagWidget(tag: 'BETA'),
                _animationController,
                beginOffset: const Offset(0.0, 0.6),
                const Interval(0.66, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget animateWeMakeStars(
    widget,
    controller,
    Interval interval, {
    Offset beginOffset = const Offset(0.0, 0.4),
  }) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: interval,
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: interval,
          ),
        ),
        child: widget,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
