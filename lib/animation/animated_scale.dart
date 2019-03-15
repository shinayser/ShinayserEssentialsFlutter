import 'package:flutter/material.dart';
import 'package:shinayser_essentials_flutter/shinayser_essentials_flutter.dart';

class AnimatedScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final int duration;
  final Curve curve;

  AnimatedScale({@required this.child, this.duration, @required this.scale, this.curve = Curves.easeInOut, Key key})
      : assert(scale >= 0 && scale <= 1),
        super(key: key);

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends State<AnimatedScale>
    with SingleTickerProviderStateMixin, AnimationControllerOwnerMixin {
  Animation<double> _animation;
  double oldScale = 0;

  @override
  void initState() {
    super.initState();
    animationDuration = Duration(milliseconds: widget.duration ?? 300);
    _animation = Tween(begin: oldScale, end: widget.scale)
        .animate(CurvedAnimation(parent: animationController, curve: widget.curve));
    animationController.forward().orCancel.catchError((error) {});
  }

  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    if (widget.scale != oldWidget.scale || widget.duration != oldWidget.scale || widget.curve != oldWidget.curve) {
      oldScale = oldWidget.scale;
      _animation = Tween(begin: oldScale, end: widget.scale)
          .animate(CurvedAnimation(parent: animationController, curve: widget.curve));
      animationDuration = Duration(milliseconds: widget.duration ?? 300);
      animationController.reset();
      animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: widget.child,
      scale: _animation,
    );
  }
}
