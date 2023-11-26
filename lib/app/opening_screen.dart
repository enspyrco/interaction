import 'package:flutter/material.dart';
import 'package:default_firebase_identity_for_perception/default_firebase_identity_for_perception.dart';

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
