library dracone;

import 'package:flutter/widgets.dart';
import 'package:fluttershy/fluttershy.dart';

class Dracone extends StatelessWidget {
  final Color backgroundColor;
  final void Function(BuildContext context) init;

  Dracone({Key key, @required this.init, Color backgroundColor})
      : backgroundColor = backgroundColor ?? Color.fromARGB(255, 0, 0, 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Fluttershy(
      backgroundColor: backgroundColor,
      game: DraconeGame(
        init: init,
      ),
    );
  }
}

class DraconeGame extends Game {
  final void Function(BuildContext context) init;

  DraconeGame({@required this.init});

  @override
  void setup(BuildContext context) {
    super.setup(context);
  }
}
