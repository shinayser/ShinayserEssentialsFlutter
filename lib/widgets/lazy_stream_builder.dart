import 'package:flutter/material.dart';

///An extension of [StreamBuilder] that only calls the [builder] method
///when the snapshot returns a non-null value, returning this way an empty Container
///or the [onWaiting] widget;
class LazyStreamBuilder<T> extends StreamBuilder<T> {
  LazyStreamBuilder({
    Key key,
    Stream<T> stream,
    AsyncWidgetBuilder<T> builder,
    this.onWaiting,
  }) : super(
          key: key,
          stream: stream,
          builder: builder,
        );

  final Widget onWaiting;

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) {
    if (currentSummary.hasData) {
      return super.build(context, currentSummary);
    } else {
      return onWaiting ?? Container();
    }
  }
}
