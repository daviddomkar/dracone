import 'package:dracone/components.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/math.dart';

class TransformSystem extends System {
  TransformSystem() : super(type: [LocalToWorld, Transform]);

  @override
  void run(World world, List<Entity> entities) {
    entities.forEach((entity) {
      var origin = entity.getComponent<Origin>();
      var parent = entity.getComponent<Parent>();
      var transform = entity.getComponent<Transform>();
      final localToWorld = entity.getComponent<LocalToWorld>();

      localToWorld.matrix.setFromTranslationRotationScale(
        transform.translation,
        transform.rotation,
        transform.scale,
      );

      if (origin != null) {
        localToWorld.matrix.translate(-origin.offset);
      }

      while (parent != null) {
        if (parent.entity.hasComponent<Transform>()) {
          transform = parent.entity.getComponent<Transform>();
          origin = parent.entity.getComponent<Origin>();

          var parentTransform = Matrix4.identity();

          parentTransform.setFromTranslationRotationScale(
            transform.translation,
            transform.rotation,
            transform.scale,
          );

          if (origin != null) {
            parentTransform.translate(-origin.offset);
          }

          localToWorld.matrix = parentTransform * localToWorld.matrix;
        }

        parent = parent.entity.getComponent<Parent>();
      }
    });
  }
}
