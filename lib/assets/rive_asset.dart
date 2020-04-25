import 'package:dracone/dracone.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flutter/services.dart';

class RiveAsset extends Asset<FlutterActor> {
  RiveAsset(String path) : super(path);

  @override
  Future<FlutterActor> loadData(AssetBundle bundle, String path) async {
    final actor = FlutterActor();
    await actor.loadFromBundle(bundle, path);
    await actor.loadImages();

    return actor;
  }
}
