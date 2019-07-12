import 'package:flutter/material.dart';

abstract class AdvancedState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);
}
