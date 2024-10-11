import 'package:flutter/material.dart';

class LineSpace {
  static double get space8 => 8;

  static double get space12 => 12;

  static double get horizontal => 16;

  static Widget box8() => SizedBox(height: LineSpace.space8);

  static Widget box12() => SizedBox(height: LineSpace.space12);

  static Widget boxHorizontal() => SizedBox(height: LineSpace.horizontal);
}
