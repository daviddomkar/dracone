import 'dart:typed_data';
import 'dart:ui';

import 'package:dracone/dracone.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class ImageAsset extends Asset<Image> {
  ImageAsset(String path) : super(path);

  @override
  Future<Image> loadData(AssetBundle bundle, String path) async {
    final ByteData data = await bundle.load(path);

    return await decodeImageFromList(Uint8List.view(data.buffer));
  }
}
