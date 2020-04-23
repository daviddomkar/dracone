import 'package:dracone/ecs.dart';

class Children with Component<Children> {
  List<Entity> entities;

  Children(this.entities);

  @override
  Children copy() {
    return Children(entities);
  }

  @override
  Children copyWith({List<Entity> entities}) {
    return Children(entities ?? this.entities);
  }
}
