import 'package:dracone/dracone.dart';
import 'package:dracone/math.dart';
import 'package:flutter/rendering.dart';

class RenderConfig {
  final int Function(RenderCommand first, RenderCommand second)
      renderOrderCompareFunction;

  final Color backgroundColor;

  RenderConfig({this.renderOrderCompareFunction, Color backgroundColor})
      : backgroundColor = backgroundColor ?? Colors.black;
}
