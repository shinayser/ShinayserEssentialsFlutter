import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final int duration;
  final double offset;
  final AnimationController controller;

  ShowUp({@required this.child, this.delay, this.duration, this.offset, this.controller, Key key}) : super(key: key);

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 500));
    } else {
      _animController = widget.controller;
    }

    final curve = CurvedAnimation(curve: Curves.ease, parent: _animController);
    _animOffset = Tween<Offset>(
      begin: Offset(0.0, widget.offset ?? 1.0),
      end: Offset.zero,
    ).animate(curve);

    if (widget.delay == null) {
      _animController.forward().orCancel;
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward().orCancel;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (widget.controller == null) {
      _animController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
