import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  FadePageRoute(
      {@required this.builder,
      Duration transitionDuration = const Duration(milliseconds: 300)})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              builder(context),
          transitionDuration: transitionDuration,
          transitionsBuilder: ((BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
                opacity: animation,
                child: child,
              )),
        );
}
