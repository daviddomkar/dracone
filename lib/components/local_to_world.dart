import 'package:dracone/ecs.dart';
import 'package:dracone/math.dart';

class LocalToWorld with Component<LocalToWorld> {
  Matrix4 matrix;

  LocalToWorld() : matrix = Matrix4.identity();
  LocalToWorld.from(Matrix4 matrix) : matrix = matrix;

  @override
  LocalToWorld copy() {
    return LocalToWorld.from(matrix);
  }
}
