import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OnlyOnePointerRecognizer extends StatelessWidget {
  final Widget? child;
  const OnlyOnePointerRecognizer({this.child});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        _OnePointerRecognizer: GestureRecognizerFactoryWithHandlers<_OnePointerRecognizer>(
          () => _OnePointerRecognizer(),
          (_OnePointerRecognizer instance) {},
        ),
      },
      child: child,
    );
  }
}

class _OnePointerRecognizer extends OneSequenceGestureRecognizer {
  int _p = 0;

  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => '_OnePointerRecognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }
}
