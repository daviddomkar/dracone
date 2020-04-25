import 'dart:async';

import 'package:flutter/foundation.dart';

class Data<D> {
  final Stream<D> _stream;

  StreamSubscription _subscription;
  D _lastValue;

  Data({@required Stream<D> stream}) : _stream = stream {
    _subscription = _stream.listen((data) {
      _lastValue = data;
      _subscription.cancel();
    });
  }

  Stream<D> get stream => _stream;
  bool get hasValue => _lastValue != null;
  D get value => _lastValue;
}
