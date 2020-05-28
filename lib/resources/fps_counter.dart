import 'package:dracone/ecs.dart';

class FPSCounter with Resource<FPSCounter> {
  double _rawFrames;
  double _time;

  FPSCounter()
      : _rawFrames = 0,
        _time = 0;

  void addFrame(double deltaTime) {
    if (_time > 1) {
      _time = 0;
      _rawFrames = 0;
    }

    _time += deltaTime;
    _rawFrames++;
  }

  int get fps =>
      (_rawFrames / _time).isFinite ? (_rawFrames / _time).round() : 0;
}
