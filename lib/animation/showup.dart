import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final double offset;
  final Animation<double> animation;

  ///This will be ignored if [animation] is provided.
  final int delay;

  ///This will be ignored if [animation] is provided.
  final int duration;

  ShowUp({
    @required this.child,
    this.delay,
    this.duration,
    this.offset,
    this.animation,
    Key key,
  }) : super(key: key);

  ///Creates a ShowUp with a offset = 0.5 (half the child's height)
  ShowUp.half({
    @required this.child,
    this.delay,
    this.duration,
    this.animation,
    Key key,
  })  : this.offset = 0.5,
        super(key: key);

  ///Creates a ShowUp with a offset = 0.2 (1/5 the child's height)
  ShowUp.fifth({
    @required this.child,
    this.delay,
    this.duration,
    this.animation,
    Key key,
  })  : this.offset = 0.2,
        super(key: key);

  ///Creates a ShowUp with a offset = 0.1 (1/10 the child's height)
  ShowUp.tenth({
    @required this.child,
    this.delay,
    this.duration,
    this.animation,
    Key key,
  })  : this.offset = 0.1,
        super(key: key);

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    if (widget.animation == null) {
      _animController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.duration ?? 500));
    }

    final curve = CurvedAnimation(
        curve: Curves.ease, parent: _animController ?? widget.animation);
    _animOffset = Tween<Offset>(
      begin: Offset(0.0, widget.offset ?? 1.0),
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
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController ?? widget.animation,
    );
  }
}
