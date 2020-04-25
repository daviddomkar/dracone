import 'package:dracone/assets.dart';
import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flutter/material.dart';

class Rive with Component<Rive> {
  Size size;
  RiveAsset rive;

  FlutterActorArtboard artboard;

  Rive({
    @required this.size,
    @required this.rive,
  });

  @override
  Rive copy() {
    return Rive(size: size.copy(), rive: rive);
  }

  @override
  Rive copyWith({Size size, ImageAsset image, Paint paint}) {
    return Rive(
      size: size ?? this.size.copy(),
      rive: image ?? this.rive,
    );
  }
}
