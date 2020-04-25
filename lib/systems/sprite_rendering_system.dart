import 'package:dracone/components.dart';
import 'package:dracone/components/sprite.dart';
import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/resources.dart';
import 'package:flutter/rendering.dart';

class SpriteRenderCommand extends RenderCommand {
  final Sprite sprite;

  SpriteRenderCommand({this.sprite, Matrix4 transform}) : super(transform);

  @override
  void render(Canvas canvas) {
    canvas.drawImageRect(
      sprite.image.data,
      Rect.fromLTWH(
        0,
        0,
        sprite.image.data.width.toDouble(),
        sprite.image.data.height.toDouble(),
      ),
      Rect.fromLTWH(
        0,
        0,
        sprite.size.width,
        sprite.size.height,
      ),
      sprite.paint,
    );
  }
}

class SpriteRenderingSystem extends System {
  SpriteRenderingSystem() : super(type: [Sprite, LocalToWorld]);

  @override
  void run(World world, List<Entity> entities) {
    final cache = world.getResource<DataCache>();
    final context = world.getResource<DraconeContext>();
    final renderer = world.getResource<Renderer>();

    entities.forEach((entity) {
      final sprite = entity.getComponent<Sprite>();

      if (sprite.image.loaded) {
        renderer.submit(SpriteRenderCommand(
          sprite: sprite,
          transform: entity.getComponent<LocalToWorld>().matrix,
        ));
      } else if (!sprite.image.loading) {
        sprite.image.load(context.assetBundle, cache);
      }
    });
  }
}
