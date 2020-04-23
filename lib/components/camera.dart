import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/material.dart';

class Camera with Component<Camera> {
  Size size;
  Color color;

  Camera({@required this.size});

  @override
  Camera copy() {
    return Camera(size: size.copy());
  }

  @override
  Camera copyWith({Size size}) {
    return Camera(size: size ?? this.size.copy());
  }
}
