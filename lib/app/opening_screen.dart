import 'package:flutter/material.dart';
import 'package:flutterfire_firebase_auth_for_perception/flutterfire_firebase_auth_for_perception.dart';

import 'app_beliefs.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SignOutOfFirebaseButton<AppBeliefs>(),
    );
  }
}
