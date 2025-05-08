import 'dart:core' as core;
import 'package:ansicolor/ansicolor.dart';

AnsiPen _green = AnsiPen()..green();
AnsiPen _red = AnsiPen()..red();
AnsiPen _white = AnsiPen()..white();
AnsiPen _blue = AnsiPen()..blue();
AnsiPen _yellow = AnsiPen()..yellow();
AnsiPen _black = AnsiPen()..black();
AnsiPen _cyan = AnsiPen()..cyan();
AnsiPen _magenta = AnsiPen()..magenta();

extension PrintExtension<T> on T {
  void print() => core.print(this);
  void printRed() => core.print(_red(this?.toString()));
  void printYellow() => core.print(_yellow(this?.toString()));
  void printBlack() => core.print(_black(this?.toString()));
  void printGreen() => core.print(_green(this?.toString()));
  void printWhite() => core.print(_white(this?.toString()));
  void printBlue() => core.print(_blue(this?.toString()));
  void printCyan() => core.print(_cyan(this?.toString()));
  void printMagenta() => core.print(_magenta(this?.toString()));
}

void printRed(core.Object? object) => core.print(_red(object?.toString()));

void printYellow(core.Object? object) => core.print(_yellow(object?.toString()));

void printBlack(core.Object? object) => core.print(_black(object?.toString()));

void printGreen(core.Object? object) => core.print(_green(object?.toString()));

void printWhite(core.Object? object) => core.print(_white(object?.toString()));

void printBlue(core.Object? object) => core.print(_blue(object?.toString()));

void printCyan(core.Object? object) => core.print(_cyan(object?.toString()));

void printMagenta(core.Object? object) =>
    core.print(_magenta(object?.toString()));
