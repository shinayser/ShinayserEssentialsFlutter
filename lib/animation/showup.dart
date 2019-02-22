import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final int duration;
  final double offset;
  final Animation<double> animation;

  ShowUp({@required this.child, this.delay, this.duration, this.offset, this.animation, Key key}) : super(key: key);

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    if (widget.animation == null) {
      _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 500));
    }

    final curve = CurvedAnimation(curve: Curves.ease, parent: _animController ?? widget.animation);
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
