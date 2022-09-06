import 'package:flutter/material.dart';
import 'package:web/Widgets/common.dart';
import 'dart:async';

class WeMakeStars extends StatefulWidget {
  const WeMakeStars({super.key});

  @override
  State<WeMakeStars> createState() => _WeMakeStarsState();
}

class _WeMakeStarsState extends State<WeMakeStars>
    with CommonWidgetMixin, TickerProviderStateMixin {
  static const double titleTop = 72.0;
  static const double descriptionTop = 126.0;
  static const double tagTop = 206.0;
  static const double imageTop = 160.0;

  final Map<String, AnimationController> animationControllers = {};
  late final Timer animationTimer;

  @override
  void initState() {
    for (var element in ['title', 'description', 'image']) {
      animationControllers[element] = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    }

    animationTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (timer.tick == 1) {
        animationControllers['title']!.forward();
      } else if (timer.tick == 2) {
        animationControllers['description']!.forward();
      } else if (timer.tick == 3) {
        animationControllers['image']!.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    for (var controller in animationControllers.values) {
      controller.dispose();
    }
    animationTimer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController titleAnimationController =
        animationControllers['title']!;
    AnimationController descriptionAnimationController =
        animationControllers['description']!;
    AnimationController imageAnimationController =
        animationControllers['image']!;

    Widget title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTitleText(
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
    );
    Widget description = getDescriptionText(
      'Support your athletes\nEnjoy the missions together.',
      style: getDescriptionStyle(
        color: Colors.white.withOpacity(0.8),
      ),
    );
    Widget image = Image.asset(
      'images/we_make_stars.png',
      height: 555.0,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );

    return SizedBox(
      height: 715.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: titleTop,
            child: animateWeMakeStars(title, titleAnimationController),
          ),
          Positioned(
            top: imageTop,
            child: animateWeMakeStars(
              image,
              imageAnimationController,
              beginOffset: const Offset(0.0, 0.1),
            ),
          ),
          Positioned(
            top: descriptionTop,
            child: animateWeMakeStars(
              description,
              descriptionAnimationController,
            ),
          ),
          Positioned(
            top: tagTop,
            child: animateWeMakeStars(
              getTag('BETA'),
              imageAnimationController,
              beginOffset: const Offset(0.0, 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget animateWeMakeStars(
    widget,
    controller, {
    Offset beginOffset = const Offset(0.0, 0.4),
  }) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(controller),
        child: widget,
      ),
    );
  }
}
