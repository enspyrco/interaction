import 'package:perception/perception.dart';

import '../app/app_beliefs.dart';

class ObservingSelfProfile extends Consideration<AppBeliefs> {
  const ObservingSelfProfile({required String selfId}) : _selfId = selfId;

  final String _selfId;

  @override
  Future<void> consider(BeliefSystem<AppBeliefs> beliefSystem) async {
    // beliefSystem.conclude(
    //     IdentityUpdates(checkingIdenState: OpeningDirectoryState.opening));

    print(_selfId);

    // var memorySystem = locate<MemorySystem>();

    // memorySystem.observe(location: '/profiles/$_selfId');

    // beliefSystem.consider(StartingAnalysisServer(
    //     directory: fileSystemSystem.directoryFromPath(_path)));

    // beliefSystem.conclude();
  }

  @override
  toJson() => {
        'name_': 'ListeningForCurrentUserIdentity',
        'state_': <String, Object?>{}
      };
}
