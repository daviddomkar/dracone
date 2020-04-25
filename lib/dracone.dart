library dracone;

import 'package:dracone/core/asset.dart';
import 'package:dracone/core/dracone_game.dart';
import 'package:dracone/core/render_config.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttershy/fluttershy.dart';

export 'package:fluttershy/fluttershy.dart' hide Game;
export 'package:ordered_set/comparing.dart';
export 'package:dracone/core/asset.dart';
export 'package:dracone/core/data.dart';
export 'package:dracone/core/dracone_game.dart';
export 'package:dracone/core/render_command.dart';
export 'package:dracone/core/render_config.dart';

class Dracone extends StatelessWidget {
  final List<System> systems;
  final void Function(BuildContext context, World world) init;
  final Color backgroundColor;
  final RenderConfig renderConfig;

  Dracone({
    Key key,
    List<Asset> assets,
    List<System> systems,
    @required this.init,
    Color backgroundColor,
    this.renderConfig,
  })  : systems = systems ?? [],
        backgroundColor = backgroundColor ?? Color.fromARGB(255, 0, 0, 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Fluttershy(
      backgroundColor: backgroundColor,
      game: DraconeGame(
        systems: systems,
        init: init,
        renderConfig: renderConfig,
      ),
    );
  }
}
