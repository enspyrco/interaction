import 'package:perception/perception.dart';

import 'opening_layer.dart';

class AppBeliefs
    implements
        CoreBeliefs,
        IdentityConcept,
        FramingConcept,
        ErrorCorrectionConcept {
  AppBeliefs({
    required this.identity,
    required this.error,
    required this.framing,
  });

  @override
  final DefaultErrorCorrectionBeliefs error;
  @override
  final DefaultFramingBeliefs framing;
  @override
  final IdentityBeliefs identity;

  static AppBeliefs get initial => AppBeliefs(
        identity: DefaultIdentityBeliefs.initial,
        error: DefaultErrorCorrectionBeliefs.initial,
        framing: const DefaultFramingBeliefs(layers: [OpeningLayer()]),
      );

  @override
  AppBeliefs copyWith({
    DefaultIdentityBeliefs? identity,
    DefaultFramingBeliefs? framing,
    DefaultErrorCorrectionBeliefs? error,
  }) =>
      AppBeliefs(
        identity: identity ?? this.identity,
        framing: framing ?? this.framing,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'auth': identity.toJson(),
        'error': error.toJson(),
        'framing': framing.toJson(),
      };
}
