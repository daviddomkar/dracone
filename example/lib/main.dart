import 'package:dracone/dracone.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dracone(
      init: (context) {},
      backgroundColor: Colors.black,
    );
  }
}
