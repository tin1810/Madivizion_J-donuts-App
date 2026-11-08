import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_watch.dart';
import 'package:madivizion_jdonuts_app/core/network/reachability.dart';

/// `connectivity_plus` says an interface is up. [Reachability] checks a host.
class PluginLinkWatch implements LinkWatch {
  const PluginLinkWatch({
    required this.connectivity,
    required this.reachability,
  });

  final Connectivity connectivity;
  final Reachability reachability;

  @override
  Stream<LinkPhase> watch() async* {
    yield await _phase();
    await for (final _ in connectivity.onConnectivityChanged) {
      yield await _phase();
    }
  }

  Future<LinkPhase> _phase() async {
    final results = await connectivity.checkConnectivity();
    final interfaceUp = results.any((item) => item != ConnectivityResult.none);
    if (!interfaceUp) {
      return LinkPhase.offline;
    }
    return decideLink(
      interfaceUp: true,
      reachable: await reachability.canReach,
    );
  }
}
