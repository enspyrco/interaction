import 'package:flutter/material.dart';

import 'app/opening_screen.dart';
import 'app/priors.dart';

void main() async {
  await setupPriors(initialScreen: const OpeningScreen());
  runApp(const MaterialApp(home: OriginOfPerception()));
}
