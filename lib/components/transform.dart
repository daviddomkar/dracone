import 'package:dracone/ecs.dart';
import 'package:dracone/math.dart';

class Transform with Component<Transform> {
  Vector3 translation;
  Quaternion rotation;
  Vector3 scale;

  Transform(
      {Vector3 translation, Quaternion rotation, Vector3 scale, Vector3 anchor})
      : translation = translation ?? Vector3.all(0.0),
        rotation = rotation ?? Quaternion.identity(),
        scale = scale ?? Vector3.all(1.0);

  @override
  Transform copy() {
    return Transform(
      translation: translation.clone(),
      rotation: rotation.clone(),
      scale: scale.clone(),
    );
  }

  @override
  Transform copyWith({
    Vector3 translation,
    Quaternion rotation,
    Vector3 scale,
  }) {
    return Transform(
      translation: translation ?? this.translation.clone(),
      rotation: rotation ?? this.rotation.clone(),
      scale: scale ?? this.scale.clone(),
    );
  }
}
