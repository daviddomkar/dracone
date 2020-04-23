import 'package:dracone/components.dart';
import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/resources.dart';
import 'package:flutter/rendering.dart';

class RectangleRenderCommand extends RenderCommand {
  final Rectangle rectangle;

  RectangleRenderCommand({this.rectangle, Matrix4 transform})
      : super(transform);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, rectangle.size.width, rectangle.size.height),
      Paint()..color = rectangle.color,
    );
  }
}

class RectangleRenderingSystem extends System {
  RectangleRenderingSystem() : super(type: [Rectangle, LocalToWorld]);

  @override
  void run(World world, List<Entity> entities) {
    final renderer = world.getResource<Renderer>();

    entities.forEach((entity) {
      renderer.submit(RectangleRenderCommand(
        rectangle: entity.getComponent<Rectangle>(),
        transform: entity.getComponent<LocalToWorld>().matrix,
      ));
    });
  }
}
