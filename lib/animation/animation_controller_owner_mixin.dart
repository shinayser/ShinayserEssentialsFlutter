import 'package:flutter/material.dart';

mixin AnimationControllerOwnerMixin<T extends StatefulWidget>
    on SingleTickerProviderStateMixin<T> {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  set animationDuration(Duration duration) {
    this.animationController.duration = duration;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
