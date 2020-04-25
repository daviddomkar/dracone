import 'package:dracone/ecs.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DraconeContext with Resource<DraconeContext> {
  final BuildContext buildContext;
  final AssetBundle assetBundle;

  DraconeContext({
    @required this.buildContext,
    @required this.assetBundle,
  });
}
