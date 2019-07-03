import 'dart:math';
import 'package:flutter/material.dart';

// Duration millis(int millis) => Duration(milliseconds: millis);
// Duration seconds(int seconds) => Duration(seconds: seconds);
// Duration minutes(int minutes) => Duration(minutes: minutes);

TargetPlatform currentPlatform(BuildContext context) =>
    Theme.of(context).platform;

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

Color hexToColor(String code) {
  if (code[0] == "#")
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  else
    return Color(int.parse(code, radix: 16) + 0xFF000000);
}

String capitalize(String text) => text[0].toUpperCase() + text.substring(1);

Duration parseDuration(String string) {
  int hours = 0;
  int minutes = 0;
//  int micros;
  List<String> parts = string.split(':');
//  if (parts.length > 2) {
  hours = int.parse(parts[0]);
//  }
//  if (parts.length > 1) {
  minutes = int.parse(parts[1]);
//  }

//  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();

  return Duration(hours: hours, minutes: minutes);
}

String printDurationAsTwoDigits(Duration duration,
    {bool includeSeconds = false}) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes${includeSeconds ? twoDigitSeconds : ""}";
}

typedef Future<T> FutureGenerator<T>();
typedef bool Predicate<T>(T value);

///A retry function for Futures
Future<T> retry<T>(
  int attempts,
  FutureGenerator aFuture, {
  Predicate<T> shouldRetry,
  Duration waitBetweenRetries,
}) async {
  try {
    var returnedValue = await aFuture();

    if (shouldRetry?.call(returnedValue) == true && attempts > 1) {
      throw Exception("Needs retry");
    } else {
      return returnedValue;
    }
  } catch (e) {
    if (attempts > 1) {
      if (waitBetweenRetries != null) {
        await Future.delayed(waitBetweenRetries);
      }
      return await retry(
        attempts - 1,
        aFuture,
        shouldRetry: shouldRetry,
        waitBetweenRetries: waitBetweenRetries,
      );
    }

    rethrow;
  }
}
