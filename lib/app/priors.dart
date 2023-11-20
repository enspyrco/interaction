import 'dart:async';

import 'package:default_flutterfire_identity_for_perception/default_flutterfire_identity_for_perception.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:introspection/introspection.dart';
import 'package:perception/perception.dart';

import '../firebase_options.dart';
import 'app_beliefs.dart';
import 'opening_layer.dart';

Future<void> setupPriors({required Widget initialScreen}) async {
  /// Setup FlutterFire
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Setup Locator so plugins can add SystemChecks & Routes, configure the AppState, etc.
  Locator.add<Habits>(DefaultHabits());
  Locator.add<PageGenerator>(DefaultPageGenerator());
  Locator.add<AppBeliefs>(AppBeliefs.initial);

  // Add the app's systems

  // Perform individual package initialization.
  initializeErrorHandling<AppBeliefs>();
  initializeIntrospection<AppBeliefs>();

  initializeIdentity<AppBeliefs>(initialScreen: initialScreen);

  // initializeFlutterfireFirebaseAuth<AppBeliefs>(
  //   signInScreen: SignInScreen<S>(),
  //   initialScreen: initialScreen,
  // );

  initializeFraming<AppBeliefs>(
    (
      layerType: OpeningLayer,
      pageGenerator: (_) => MaterialPage(child: initialScreen),
    ),
  );

  /// Finally, create our BeliefSystem and add to the Locator.
  final beliefSystem = DefaultBeliefSystem<AppBeliefs>(
      beliefs: locate<AppBeliefs>(),
      errorHandlers: DefaultErrorHandlers<AppBeliefs>(),
      habits: locate<Habits>(),
      beliefSystemFactory: ParentingBeliefSystem.new);

  Locator.add<BeliefSystem<AppBeliefs>>(beliefSystem);
}

class OriginOfPerception extends StatelessWidget {
  const OriginOfPerception({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (const bool.fromEnvironment('IN-APP-INTROSPECTION'))
          Expanded(
            flex: 1,
            child: Material(
              child: IntrospectionScreen(locate<IntrospectionHabit>().stream),
            ),
          ),
        Expanded(
          flex: 1,
          child: FramingBuilder<AppBeliefs>(
            onInit: (beliefSystem) {
              beliefSystem.consider(const ObservingIdentity<AppBeliefs,
                  FlutterfireFirebaseAuthSubsystem>());
            },
          ),
        ),
      ],
    );
  }
}
