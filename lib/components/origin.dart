import 'package:dracone/ecs.dart';
import 'package:dracone/math.dart';
import 'package:flutter/foundation.dart';

class Origin with Component<Origin> {
  Vector3 offset;

  Origin({@required this.offset});

  @override
  Origin copy() {
    return Origin(offset: this.offset);
  }

  @override
  Origin copyWith({Vector3 offset}) {
    return Origin(offset: offset ?? this.offset);
  }
}
