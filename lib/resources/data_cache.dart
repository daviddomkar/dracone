import 'dart:collection';

import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';

class DataCache with Resource<DataCache> {
  final HashMap<Type, HashMap<String, Data>> _cache;

  DataCache() : _cache = HashMap();

  void add<D>(String path, Data<D> data) {
    if (!_cache.containsKey(D)) {
      _cache[D] = HashMap();
    }

    _cache[D][path] = data;
  }

  bool has<D>(String path) {
    return _cache.containsKey(D) && _cache[D].containsKey(path);
  }

  Data<D> get<D>(String path) {
    return _cache[D][path];
  }
}
