import 'package:flutter/material.dart';

import 'app.dart';
import 'model/config.dart';

void main() {
  runConfig(Flavor.PRODUCTION);
  runApp(const App());
}
