import 'package:flutter/material.dart';
import 'package:shinayser_essentials_flutter/shinayser_essentials_flutter.dart';

class PopupDrawer extends StatefulWidget {
  final Widget child;

  PopupDrawer({this.child});

  @override
  _PopupDrawerState createState() => _PopupDrawerState();
}

class _PopupDrawerState extends State<PopupDrawer> with SingleTickerProviderStateMixin, AnimationControllerOwnerMixin {
  static const kDrawerWidth = 304.0;

  Animation<Offset> _offsetTransition;

  @override
  void initState() {
    super.initState();
    animationDuration = millis(300);
  }

  @override
  void didChangeDependencies() {
    _offsetTransition = Tween<Offset>(end: Offset(1, 0), begin: Offset.zero).animate(this.animationController)
      ..addStatusListener((it) {
        if (it == AnimationStatus.completed) {
          Navigator.of(context).pop(null);
        }
      });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - kDrawerWidth),
      child: SlideTransition(
        position: _offsetTransition,
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            animationController.value += details.delta.dx / kDrawerWidth;
          },
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity.abs() > 500) {
              if (details.primaryVelocity >= 0) {
                animationController.forward();
              } else {
                animationController.reverse();
              }
            } else if (animationController.value > 0.5) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          child: Container(
            width: kDrawerWidth,
            child: Drawer(
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

Future<T> showDialogDrawer<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  Duration animationDuration = const Duration(milliseconds: 200),
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismissable",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: millis(200),
    transitionBuilder: (context, anim, anim2, child) => SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        ),
    pageBuilder: (context, anim, anim2) => PopupDrawer(
          child: builder(context),
        ),
  );
}
