import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/material.dart';

class Rectangle with Component<Rectangle> {
  Size size;
  Paint paint;

  Rectangle({@required this.size, @required this.paint});

  @override
  Rectangle copy() {
    return Rectangle(size: size.copy(), paint: paint);
  }

  @override
  Rectangle copyWith({Size size, Paint color}) {
    return Rectangle(
        size: size ?? this.size.copy(), paint: color ?? this.paint);
  }
}
