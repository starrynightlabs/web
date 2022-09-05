import 'package:flutter/material.dart';
import 'package:web/Widgets/part.dart';
import 'package:web/utils.dart';
import 'dart:async';

class WeMakeStars extends Part {
  final double titleTop = 72.0;
  final double descriptionTop = 126.0;
  final double tagTop = 206.0;
  final double imageTop = 160.0;

  final Map<String, AnimationController> animationControllers;

  const WeMakeStars(
    super.isAnimated,
    super.currentPixels,
    this.animationControllers, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController titleAnimationController =
        animationControllers['title']!;
    AnimationController descriptionAnimationController =
        animationControllers['description']!;
    AnimationController imageAnimationController =
        animationControllers['image']!;

    startWeMakeStarsAnimation();

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

  void startWeMakeStarsAnimation() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (timer.tick == 1) {
        animationControllers['title']!.forward();
      } else if (timer.tick == 2) {
        animationControllers['description']!.forward();
      } else if (timer.tick == 3) {
        animationControllers['image']!.forward();
      } else {
        timer.cancel();
      }
    });
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
