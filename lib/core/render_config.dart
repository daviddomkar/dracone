import 'package:dracone/dracone.dart';

class RenderConfig {
  final int Function(RenderCommand first, RenderCommand second)
      renderOrderCompareFunction;

  RenderConfig({this.renderOrderCompareFunction});
}
