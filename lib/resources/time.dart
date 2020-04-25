import 'package:dracone/ecs.dart';

class Time with Resource<Time> {
  double _time;
  double _deltaTime;
  double scale;

  Time()
      : _time = 0,
        _deltaTime = 0,
        scale = 1;

  void add(double deltaTime) {
    _time += deltaTime;
    _deltaTime = deltaTime;
  }

  double get time => _time;
  double get deltaTime => _deltaTime;
  double get scaledDeltaTime => _deltaTime * scale;
}
