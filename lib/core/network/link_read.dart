import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';

/// The latest network phase, plus later changes.
abstract class LinkRead {
  LinkPhase get phase;

  Stream<LinkPhase> watch();
}
