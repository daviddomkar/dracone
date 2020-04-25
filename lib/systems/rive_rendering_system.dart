import 'package:dracone/components.dart';
import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/resources.dart';
import 'package:flutter/rendering.dart';

class RiveRenderCommand extends RenderCommand {
  final Rive rive;

  RiveRenderCommand({this.rive, Matrix4 transform}) : super(transform);

  @override
  void render(Canvas canvas) {
    canvas.scale(
      rive.size.width / rive.artboard.width,
      rive.size.height / rive.artboard.height,
    );

    rive.artboard.draw(canvas);
  }
}

class RiveRenderingSystem extends System {
  RiveRenderingSystem() : super(type: [Rive, LocalToWorld]);

  @override
  void run(World world, List<Entity> entities) {
    final cache = world.getResource<DataCache>();
    final context = world.getResource<DraconeContext>();
    final renderer = world.getResource<Renderer>();

    entities.forEach((entity) {
      final rive = entity.getComponent<Rive>();

      if (rive.rive.loaded) {
        if (rive.artboard == null) {
          rive.artboard = rive.rive.data.artboard.makeInstance();
          rive.artboard.makeInstance();
          rive.artboard.initializeGraphics();
          rive.artboard.advance(0.0);
        }

        renderer.submit(RiveRenderCommand(
          rive: rive,
          transform: entity.getComponent<LocalToWorld>().matrix,
        ));
      } else if (!rive.rive.loading) {
        rive.rive.load(context.assetBundle, cache);
      }
    });
  }
}
