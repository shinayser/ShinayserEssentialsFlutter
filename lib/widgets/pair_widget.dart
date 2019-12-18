import 'package:flutter/material.dart';

class PairWidget extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final double spacing;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;

  const PairWidget({
    Key key,
    this.direction = Axis.horizontal,
    this.child1,
    this.child2,
    this.spacing = 4,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  const PairWidget.horizontal({
    Key key,
    this.child1,
    this.child2,
    this.spacing = 4,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  })  : this.direction = Axis.horizontal,
        super(key: key);

  const PairWidget.vertical({
    Key key,
    this.child1,
    this.child2,
    this.spacing = 4,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  })  : this.direction = Axis.vertical,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: _children(),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: _children(),
      );
    }
  }

  List<Widget> _children() {
    return <Widget>[
      if (child1 != null) child1,
      if (child1 != null && child2 != null && spacing > 0)
        SizedBox(
          width: direction == Axis.horizontal ? spacing : 0,
          height: direction == Axis.vertical ? spacing : 0,
        ),
      if (child2 != null) child2,
    ];
  }
}
