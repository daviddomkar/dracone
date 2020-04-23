import 'package:dracone/components.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/resources.dart';

class CameraSystem extends System {
  CameraSystem() : super(type: [Camera, LocalToWorld]);

  @override
  void run(World world, List<Entity> entities) {
    final renderer = world.getResource<Renderer>();
    final screenDimensions = world.getResource<ScreenDimensions>();

    entities.forEach((entity) {
      renderer.cameraSize = entity.getComponent<Camera>().size.copy();
      renderer.screenSize = screenDimensions.size;
      renderer.transform = entity.getComponent<LocalToWorld>().matrix;
    });
  }
}
