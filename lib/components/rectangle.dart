import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/material.dart';

class Rectangle with Component<Rectangle> {
  Size size;
  Color color;

  Rectangle({@required this.size, @required this.color});

  @override
  Rectangle copy() {
    return Rectangle(size: size.copy(), color: color);
  }

  @override
  Rectangle copyWith({Size size, Color color}) {
    return Rectangle(
        size: size ?? this.size.copy(), color: color ?? this.color);
  }
}
