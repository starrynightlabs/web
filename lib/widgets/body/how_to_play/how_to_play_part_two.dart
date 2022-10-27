import 'package:flutter/material.dart';
import 'package:web/utils/observer_interface/listener.dart' as my;
import 'package:web/scroll_notifier.dart';
import 'package:web/utils/styles.dart';
import 'package:web/widgets/body/how_to_play/how_to_play_title.dart';
import 'package:web/widgets/body/how_to_play/text_highlighter.dart';
import 'package:web/widgets/common/animated_widget.dart' as my;

class HowToPlayPartTwo extends StatefulWidget {
  const HowToPlayPartTwo({Key? key, required this.scrollNotifier})
      : super(key: key);

  final ScrollNotifier scrollNotifier;
  final double titleTop = 788.0;
  final double descriptionTop = 892.0;
  final double imageTop = 1024.0;
  final double decorationTop = 976.0;
  final String howToPlayDescription = '''
Your athletes with our ‘stars’ and
participate in your athletes
journey together.''';
  final double startingPoint = 1713.0;

  @override
  State<HowToPlayPartTwo> createState() => _HowToPlayPartTwoState();
}

class _HowToPlayPartTwoState extends State<HowToPlayPartTwo>
    with SingleTickerProviderStateMixin
    implements my.Listener<double> {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<Offset>(
      begin: const Offset(300, 0.0),
      end: const Offset(120, 0.0),
    )
        .chain(CurveTween(curve: Curves.easeOutQuart))
        .animate(_animationController);
    widget.scrollNotifier.addListener(this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.scrollNotifier.deleteListener(this);
    super.dispose();
  }

  @override
  void update(double subject) {
    if (!_animationController.isAnimating && subject > widget.startingPoint) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 822.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(
              'images/line_2.png',
              color: NyxsColors.mint,
              height: 484.1,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        Positioned(
          top: widget.imageTop,
          child: AnimatedBuilder(
            animation: _animation,
            child: Padding(
              padding: const EdgeInsets.only(left: 33.0),
              child: Image.asset(
                'images/player_cards.png',
                height: 137.0,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
              ),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: _animation.value,
                child: Opacity(
                  opacity: _animationController.value,
                  child: child,
                ),
              );
            },
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: widget.scrollNotifier,
          position: widget.decorationTop,
          startingPoint: 1763.0 + 80,
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 138.0),
            child: Image.asset(
              'images/decoration_2.png',
              width: 152.0,
              height: 246.0,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: widget.scrollNotifier,
          position: widget.descriptionTop,
          startingPoint: 1550.0,
          child: Stack(
            children: [
              const Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 187.0,
                    top: 14.0,
                  ),
                  child: TextHighlighter(width: 51.0),
                ),
              ),
              Positioned(
                child: Text(
                  widget.howToPlayDescription,
                  style: getDescriptionStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        my.AnimatedWidget(
          scrollNotifier: widget.scrollNotifier,
          position: widget.titleTop,
          startingPoint: 1504.0,
          child: const HowToPlayTitle(number: 2, title: 'Support'),
        ),
      ],
    );
  }
}
