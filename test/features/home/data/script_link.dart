import 'dart:async';

import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_read.dart';

class ScriptLink implements LinkRead {
  ScriptLink(this.phase);

  @override
  LinkPhase phase;

  final _changes = StreamController<LinkPhase>.broadcast();

  @override
  Stream<LinkPhase> watch() => _changes.stream;
}
