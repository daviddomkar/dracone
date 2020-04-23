import 'package:dracone/ecs.dart';
import 'package:flutter/widgets.dart';

class DraconeContext with Resource<DraconeContext> {
  final BuildContext buildContext;

  DraconeContext({@required this.buildContext});
}
