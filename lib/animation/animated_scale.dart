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
  _AnimatedSafadoState createState() => _AnimatedSafadoState();
}

class _AnimatedSafadoState extends State<AnimatedScale>
    with SingleTickerProviderStateMixin, AnimationControllerOwnerMixin {
  Animation<double> _animation;
  double oldScale = 0;

  Timer currentTimer;

  @override
  void initState() {
    super.initState();
    animationDuration = Duration(milliseconds: widget.duration ?? 300);
    _animation = Tween(begin: oldScale, end: widget.scale)
        .animate(CurvedAnimation(parent: animationController, curve: widget.curve));

    animationController.addStatusListener((AnimationStatus it) {
      if (it == AnimationStatus.completed) {
        oldScale = widget.scale;
      }
    });

    _runAnimation();
  }

  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scale != oldWidget.scale || widget.duration != oldWidget.duration || widget.curve != oldWidget.curve) {
      _animation = Tween(begin: oldScale, end: widget.scale)
          .animate(CurvedAnimation(parent: animationController, curve: widget.curve));

      animationDuration = Duration(milliseconds: widget.duration ?? 300);
      animationController.reset();
      _runAnimation();
    }
  }

  void _runAnimation() {
    currentTimer?.cancel();
    if (widget.delay != null) {
      currentTimer = Timer(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          animationController.forward().orCancel.catchError((error) {});
        }
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
