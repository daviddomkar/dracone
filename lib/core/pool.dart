import 'dart:collection';

import 'package:flutter/foundation.dart';
mixin Poolable {
  void reset() {}
  void retrieve() {}
}
class Pool<T extends Poolable> {
  final List<T> _items;
  final T Function() _generate;

  Pool({@required T Function() generate})
      : _items = List(),
        _generate = generate;

  void reset(T item) {
    item.reset();
    _items.add(item);
  }

  T get item =>
      _items.isNotEmpty ? (_items.removeLast()..retrieve()) : _generate();

  int get size => _items.length;
}

class HashPool<H, T extends Poolable> {
  final HashMap<H, Pool<T>> _hashedPools;
  final T Function(H key) _generate;

  HashPool({T Function(H key) generate})
      : _hashedPools = HashMap(),
        _generate = generate;

  void reset(H key, T item) {
    _hashedPools[key].reset(item);
  }

  T get(H key) {
    if (!_hashedPools.containsKey(key))
      _hashedPools[key] = Pool<T>(generate: () => _generate(key));

    return _hashedPools[key].item;
  }

  int get size => _hashedPools.entries
      .fold(0, (previousValue, element) => previousValue + element.value.size);
}
