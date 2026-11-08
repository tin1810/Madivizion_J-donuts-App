import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';

/// Emits a new phase when connectivity or reachability changes.
abstract class LinkWatch {
  const LinkWatch();

  Stream<LinkPhase> watch();
}

/// One fixed phase. Tests use this so they never open a platform channel.
final class FixedLinkWatch extends LinkWatch {
  const FixedLinkWatch(this.phase);

  final LinkPhase phase;

  @override
  Stream<LinkPhase> watch() => Stream<LinkPhase>.value(phase);
}
