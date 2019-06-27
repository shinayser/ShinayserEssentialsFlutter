import 'dart:async';

import 'package:flutter/material.dart';

class ShowDown extends StatefulWidget {
  final Widget child;
  final double offset;
  final Animation<double> animation;

  ///This will be ignored if [animation] is provided.
  final int delay;

  ///This will be ignored if [animation] is provided.
  final int duration;

  ShowDown({
    @required this.child,
    this.delay,
    this.duration,
    this.offset,
    this.animation,
    Key key,
  }) : super(key: key);

  ///Creates a ShowUp with a offset = 0.5 (half the child's height)
  ShowDown.half({
    @required this.child,
    this.delay,
    this.duration,
    this.animation,
    Key key,
  })  : this.offset = 0.5,
        super(key: key);

  ///Creates a ShowUp with a offset = 0.2 (1/5 the child's height)
  ShowDown.fifth({
    @required this.child,
    this.delay,
    this.duration,
    this.animation,
    Key key,
  })  : this.offset = 0.2,
        super(key: key);

  @override
  _ShowDownState createState() => _ShowDownState();
}

class _ShowDownState extends State<ShowDown>
    with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;
  Animation<double> _animOpacity;

  @override
  void initState() {
    super.initState();

    if (widget.animation == null) {
      _animController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration ?? 500),
      );
    }

    _animOpacity =
        CurvedAnimation(curve: Interval(0.0, 0.4), parent: _animController);

    final curve = CurvedAnimation(
      curve: Curves.ease,
      parent: _animController ?? widget.animation,
    );

    _animOffset = Tween<Offset>(
      begin: Offset(0.0, -(widget.offset ?? 1.0)),
      end: Offset.zero,
    ).animate(curve);

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
    return FadeTransition(
      opacity: _animOpacity ?? widget.animation,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
