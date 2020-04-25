import 'package:dracone/dracone.dart';
import 'package:dracone/assets.dart';
import 'package:dracone/components.dart';
import 'package:dracone/math.dart' hide Colors;
import 'package:example/test_system.dart';
import 'package:flutter/material.dart' hide Transform;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dracone(
      systems: [
        TestSystem(),
      ],
      init: (context, world) {
        world
            .createEntity()
            .withComponent(Transform(
              translation: Vector3(0.0, 0.0, 0.0),
            ))
            .withComponent(
              Rectangle(
                size: Size(180.0, 180.0),
                paint: Paint()..color = Colors.red,
              ),
            )
            .build();

        world
            .createEntity()
            .withComponent(Transform(
              translation: Vector3(-100.0, -400.0, 0.0),
              rotation: Quaternion.axisAngle(Vector3(0.0, 0.0, 1.0), 0.7),
            ))
            .withComponent(
              Camera(
                size: Size(double.infinity, 900.0),
              ),
            )
            .build();
      },
      renderConfig: RenderConfig(
        backgroundColor: Colors.green,
        renderOrderCompareFunction: Comparing.join([
          (command) => command.transform.getTranslation().z,
          (command) => command.transform.getTranslation().y,
          (command) => command.transform.getTranslation().x,
        ]),
      ),
    );
  }
}
