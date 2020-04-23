import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/rendering.dart';
import 'package:ordered_set/ordered_set.dart';

class Renderer with Resource<Renderer> {
  final OrderedSet<RenderCommand> _renderCommands;

  Matrix4 transform;
  Size cameraSize;
  Size screenSize;

  Renderer([int Function(RenderCommand first, RenderCommand second) compare])
      : _renderCommands = OrderedSet(
          compare ??
              Comparing.on((command) => command.transform.getTranslation().z),
        ),
        transform = Matrix4.identity();

  void submit(RenderCommand command) {
    _renderCommands.add(command);
  }

  void render(Canvas canvas) {
    if (cameraSize != null && screenSize != null) {
      if (cameraSize.width != double.infinity &&
          cameraSize.height != double.infinity) {
        canvas.scale(
          screenSize.width / cameraSize.width,
          screenSize.height / cameraSize.height,
        );
      } else if (cameraSize.width == double.infinity &&
          cameraSize.height != double.infinity) {
        canvas.scale(screenSize.height / cameraSize.height);
      } else if (cameraSize.width != double.infinity &&
          cameraSize.height == double.infinity) {
        canvas.scale(screenSize.width / cameraSize.width);
      }
    }

    canvas.transform(Matrix4.inverted(transform).storage);

    _renderCommands.forEach((command) {
      canvas.save();
      canvas.transform(command.transform.storage);

      command.render(canvas);

      canvas.restore();
    });

    _renderCommands.clear();
  }
}
