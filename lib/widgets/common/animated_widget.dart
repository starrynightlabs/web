import 'package:flutter/material.dart';
import 'package:web/utils/observer_interface/listener.dart' as my;
import 'package:web/utils/observer_interface/subject.dart';

class AnimatedWidget extends StatefulWidget {
  const AnimatedWidget({
    Key? key,
    required this.scrollNotifier,
    required this.position,
    required this.startingPoint,
    required this.child,
    this.margin = 10,
    this.reverse = false,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final double position;
  final double startingPoint;
  final int margin;
  final bool reverse;
  final Duration duration;
  final Subject scrollNotifier;
  final Widget child;

  @override
  State<AnimatedWidget> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget>
    with SingleTickerProviderStateMixin
    implements my.Listener<double> {
  late final AnimationController _animationController;
  late final Animation _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    widget.scrollNotifier.addListener(this);
    _positionAnimation =
        CurveTween(curve: Curves.easeOutQuart).animate(_animationController);
  }

  @override
  void dispose() {
    widget.scrollNotifier.deleteListener(this);
    super.dispose();
  }

  @override
  void update(double subject) {
    if (!_animationController.isAnimating && subject > widget.startingPoint) {
      _animationController.forward();
    }
  }

  double get begin => widget.reverse
      ? widget.position - widget.margin
      : widget.position + widget.margin;

  double get offsetToEnd => widget.position - begin;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _positionAnimation,
      builder: (context, child) {
        return Positioned(
          top: begin + _positionAnimation.value * (offsetToEnd),
          child: Opacity(
            opacity: _animationController.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
