library dracone;

import 'package:dracone/core/asset.dart';
import 'package:dracone/core/dracone_game.dart';
import 'package:dracone/core/render_config.dart';
import 'package:dracone/ecs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttershy/fluttershy.dart';

export 'package:fluttershy/fluttershy.dart' hide Game;
export 'package:ordered_set/comparing.dart';
export 'package:dracone/core/asset.dart';
export 'package:dracone/core/data.dart';
export 'package:dracone/core/dracone_game.dart';
export 'package:dracone/core/pool.dart';
export 'package:dracone/core/render_command.dart';
export 'package:dracone/core/render_config.dart';

class Dracone extends StatelessWidget {
  final List<System> systems;
  final void Function(BuildContext context, World world) init;
  final RenderConfig renderConfig;

  Dracone({
    Key key,
    List<Asset> assets,
    List<System> systems,
    @required this.init,
    this.renderConfig,
  })  : systems = systems ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Fluttershy(
      backgroundColor: renderConfig?.backgroundColor ?? Colors.black,
      game: DraconeGame(
        systems: systems,
        init: init,
        renderConfig: renderConfig,
      ),
    );
  }
}
