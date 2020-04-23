import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';

class ScreenDimensions with Resource<ScreenDimensions> {
  Size size;

  ScreenDimensions({this.size});
}
