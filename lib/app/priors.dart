import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfire_firebase_auth_for_perception/flutterfire_firebase_auth_for_perception.dart';
import 'package:perception/perception.dart';
import 'package:introspection/introspection.dart';

import 'app_beliefs.dart';
import 'opening_layer.dart';

Future<void> setupPriors({required Widget initialScreen}) async {
  // Setup Locator so plugins can add SystemChecks & Routes, configure the AppState, etc.
  Locator.add<Habits>(DefaultHabits());
  Locator.add<PageGenerator>(DefaultPageGenerator());
  Locator.add<AppBeliefs>(AppBeliefs.initial);

  // Add the app's systems

  // Perform individual package initialization.
  initializeErrorHandling<AppBeliefs>();
  initializeIntrospection<AppBeliefs>();

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
  const OriginOfPerception({Key? key}) : super(key: key);

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
              beliefSystem.consider(const ObservingIdentity());
            },
          ),
        ),
      ],
    );
  }
}
