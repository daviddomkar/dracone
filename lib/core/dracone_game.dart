import 'package:dracone/components.dart';
import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';
import 'package:dracone/resources.dart';
import 'package:dracone/systems/camera_system.dart';
import 'package:dracone/systems/rectangle_rendering_system.dart';
import 'package:dracone/systems/rive_rendering_system.dart';
import 'package:dracone/systems/sprite_rendering_system.dart';
import 'package:dracone/systems/transform_system.dart';
import 'package:flutter/widgets.dart' hide Transform;
import 'package:fluttershy/fluttershy.dart';

class DraconeGame extends Game {
  final List<System> systems;
  final void Function(BuildContext context, World world) init;
  final RenderConfig renderConfig;

  final World _world;

  DraconeGame({
    List<System> systems,
    @required this.init,
    this.renderConfig,
  })  : systems = systems ?? [],
        _world = World(
          systems: [
            ...systems,
            TransformSystem(),
            CameraSystem(),
            RectangleRenderingSystem(),
            SpriteRenderingSystem(),
            RiveRenderingSystem(),
          ],
        );

  @override
  void setup(BuildContext context) {
    super.setup(context);

    _world.addEventListener(_worldEventListener);

    init(context, _world);

    _initResources(context);
  }

  @override
  void event(Event event) {
    switch (event.type) {
      case ResizeEvent:
        _resize((event as ResizeEvent).size);
        break;
    }

    _world.getResource<EventDispatcher>().dispatch(event);
  }

  @override
  void update(double deltaTime) {
    _world.getResource<FPSCounter>().addFrame(deltaTime);
    _world.getResource<Time>().add(deltaTime);
    _world.run();
    _world.getResource<EventDispatcher>().flush();
  }

  @override
  void render(Canvas canvas) {
    _world.getResource<Renderer>().render(canvas);
  }

  @override
  void destroy(BuildContext context) {
    _world.destroyResources();

    _world.destroyEntities();

    _world.removeEventListener(_worldEventListener);

    super.destroy(context);
  }

  void _initResources(BuildContext context) {
    _world.addResource(DataCache());
    _world.addResource(DraconeContext(
      buildContext: context,
      assetBundle: DefaultAssetBundle.of(context),
    ));
    _world.addResource(EventDispatcher());
    _world.addResource(FPSCounter());
    _world.addResource(Renderer(this.renderConfig?.renderOrderCompareFunction));
    _world.addResource(ScreenDimensions(size: Size(0.0, 0.0)));
    _world.addResource(Time());
  }

  void _resize(Size size) {
    _world.getResource<ScreenDimensions>().size = size;
  }

  void _worldEventListener(WorldEvent event) {
    if (event is ComponentAddedEvent) {
      _componentAdded(event.entity, event.componentType);
    } else if (event is ComponentReplacedEvent) {
      _componentReplaced(event.entity, event.componentType, event.oldComponent);
    } else if (event is ComponentRemovedEvent) {
      _componentRemoved(
          event.entity, event.componentType, event.removedComponent);
    }
  }

  void _componentAdded(Entity entity, Type type) {
    switch (type) {
      case Transform:
        entity.addComponent(LocalToWorld());
        break;
      case Parent:
        final parent = entity.getComponent<Parent>();
        final children = parent.entity.getComponent<Children>();

        if (children != null) {
          children.entities.add(entity);
        } else {
          parent.entity.addComponent(Children([entity]));
        }
        break;
    }
  }

  void _componentReplaced(Entity entity, Type type, Component oldComponent) {
    switch (type) {
      case Parent:
        final oldParent = oldComponent as Parent;
        final newParent = entity.getComponent<Parent>();

        oldParent.entity
            .getComponent<Children>()
            .entities
            .removeWhere((child) => child.id == entity.id);

        final children = newParent.entity.getComponent<Children>();

        if (children != null) {
          children.entities.add(entity);
        } else {
          newParent.entity.addComponent(Children([entity]));
        }

        break;
    }
  }

  void _componentRemoved(Entity entity, Type type, Component removedComponent) {
    switch (type) {
      case Transform:
        entity.removeComponent<LocalToWorld>();
        break;
      case Parent:
        final parent = removedComponent as Parent;
        final children = parent.entity.getComponent<Children>();

        children.entities.removeWhere((child) => child.id == entity.id);

        if (children.entities.isEmpty) {
          parent.entity.removeComponent<Children>();
        }

        break;
    }
  }
}
