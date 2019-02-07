import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget widget;

  FadePageRoute({@required this.widget, Duration transitionDuration = const Duration(milliseconds: 300)})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    widget,
    transitionDuration: transitionDuration,
    transitionsBuilder: ((BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,
        Widget child) =>
        FadeTransition(
          opacity: animation,
          child: child,
        )),
  );
}
