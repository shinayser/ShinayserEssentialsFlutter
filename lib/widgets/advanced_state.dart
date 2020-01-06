import 'package:flutter/material.dart';
import 'package:shinayser_essentials_flutter/utils/util_extensions.dart';

abstract class AdvancedState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => context.theme;

  MediaQueryData get media => context.mediaQuery;

  NavigatorState get navigator => context.navigator;
}
