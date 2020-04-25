import 'package:dracone/assets.dart';
import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/material.dart';

class Sprite with Component<Sprite> {
  Size size;
  ImageAsset image;
  Paint paint;

  Sprite({
    @required this.size,
    @required this.image,
    Paint paint,
  }) : paint = paint ?? Paint()
          ..filterQuality = FilterQuality.high;

  @override
  Sprite copy() {
    return Sprite(size: size.copy(), image: image, paint: paint);
  }

  @override
  Sprite copyWith({Size size, ImageAsset image, Paint paint}) {
    return Sprite(
      size: size ?? this.size.copy(),
      image: image ?? this.image,
      paint: paint ?? this.paint,
    );
  }
}
