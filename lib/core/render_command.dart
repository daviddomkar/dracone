import 'package:dracone/math.dart';
import 'package:flutter/rendering.dart';

abstract class RenderCommand {
  final Matrix4 transform;

  RenderCommand(this.transform);

  void render(Canvas canvas);
}
