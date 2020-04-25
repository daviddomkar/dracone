import 'dart:async';

import 'package:dracone/dracone.dart';
import 'package:dracone/resources.dart';
import 'package:flutter/services.dart';

abstract class Asset<D> {
  final String _path;

  StreamSubscription _subscription;
  bool _loading;

  D _data;

  Asset(String path)
      : _path = path,
        _loading = false;

  Future<void> load(AssetBundle bundle, [DataCache cache]) async {
    _loading = true;

    if (cache != null) {
      if (!cache.has<D>(_path)) {
        cache.add<D>(
          _path,
          Data(
            stream: loadData(bundle, _path).asStream().asBroadcastStream(),
          ),
        );
      }

      final data = cache.get<D>(_path);

      if (data.hasValue) {
        _data = data.value;
        _loading = false;
      } else {
        _subscription = data.stream.listen((data) {
          _data = data;
          _subscription.cancel();
        });
      }
    } else {
      _data = await loadData(bundle, _path);
      _loading = false;
    }
  }

  Future<D> loadData(AssetBundle bundle, String path);

  D get data => _data;

  bool get loading => _loading;
  bool get loaded => _data != null;
}
