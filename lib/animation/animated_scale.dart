import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shinayser_essentials_flutter/shinayser_essentials_flutter.dart';

class AnimatedScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final int duration;
  final int delay;
  final Curve curve;

  AnimatedScale({
    @required this.child,
    this.duration,
    this.delay,
    @required this.scale,
    this.curve = Curves.easeInOut,
    Key key,
  })  : assert(scale >= 0 && scale <= 1),
        super(key: key);

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends State<AnimatedScale>
    with SingleTickerProviderStateMixin, AnimationControllerOwnerMixin {
  Animation<double> _animation;
  double oldScale = 0;

  @override
  void initState() {
    super.initState();
    animationDuration = Duration(milliseconds: widget.duration ?? 300);
    _animation = Tween(begin: oldScale, end: widget.scale)
        .animate(CurvedAnimation(parent: animationController, curve: widget.curve));
    _runAnimation();
  }

  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    if (widget.scale != oldWidget.scale || widget.duration != oldWidget.scale || widget.curve != oldWidget.curve) {
      oldScale = oldWidget.scale;
      _animation = Tween(begin: oldScale, end: widget.scale)
          .animate(CurvedAnimation(parent: animationController, curve: widget.curve));

      animationDuration = Duration(milliseconds: widget.duration ?? 300);
      animationController.reset();
      _runAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _runAnimation() {
    if (widget.delay != null) {
      Timer(Duration(milliseconds: widget.delay), () {
        animationController.forward().orCancel.catchError((error) {});
      });
    } else {
      animationController.forward().orCancel.catchError((error) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: widget.child,
      scale: _animation,
    );
  }
}
