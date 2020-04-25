import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/resources.dart';

class TestSystem extends System {
  TestSystem() : super(type: []);

  @override
  void run(World world, List<Entity> entities) {
    final eventDispatcher = world.getResource<EventDispatcher>();

    eventDispatcher.read<PointerUpEvent>(
      (event) => print(event),
    );
  }
}
