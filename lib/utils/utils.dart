import 'dart:math';
import 'package:flutter/material.dart';

Duration millis(int millis) => Duration(milliseconds: millis);
Duration seconds(int seconds) => Duration(seconds: seconds);
Duration minutes(int minutes) => Duration(minutes: minutes);

TargetPlatform currentPlatform(BuildContext context) => Theme.of(context).platform;

bool isDebug() {
  bool isDebug = false;
  assert(() {
    isDebug = true;
    return true;
  }());

  return isDebug;
}

int randomInt([int max]) => Random.secure().nextInt(max ?? (1 << 32));
bool randomBoolean() => Random.secure().nextBool();
double getRadian(double degree) => degree * pi / 180;
Future delay(int millis) => Future.delayed(Duration(milliseconds: millis));

void repeat(int amount, ValueChanged<int> callback) {
  for (int i = 0; i < amount; i++) {
    callback(i);
  }
}

Color hexToColor(String code) => Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
