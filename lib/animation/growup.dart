import 'dart:async';

import 'package:flutter/material.dart';

class GrowUp extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;

  ///This will be ignored if [animation] is provided.
  final int delay;

  ///This will be ignored if [animation] is provided.
  final int duration;

  ///This will be ignored if [animation] is provided.
  final Curve curve;

  GrowUp({
    @required this.child,
    this.delay,
    this.duration,
    this.animation,
    this.curve = Curves.linear,
    Key key,
  }) : super(key: key);

  @override
  _GrowUpState createState() => _GrowUpState();
}

class _GrowUpState extends State<GrowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    if (widget.animation == null) {
      _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 200));
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animController, curve: widget.curve));
    }

    if (_animController != null) {
      if (widget.delay == null) {
        _animController.forward().orCancel.catchError((error) {});
      } else {
        Timer(Duration(milliseconds: widget.delay), () {
          if (mounted) {
            _animController.forward().orCancel.catchError((error) {});
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: widget.child,
      scale: _animation ?? widget.animation,
    );
  }
}
