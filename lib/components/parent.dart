import 'package:dracone/ecs.dart';

class Parent with Component<Parent> {
  final Entity entity;

  Parent(this.entity);

  @override
  Parent copy() {
    return Parent(entity);
  }

  @override
  Parent copyWith({Entity entity}) {
    return Parent(entity ?? this.entity);
  }
}
