import 'package:madivizion_jdonuts_app/app/connectivity/link_bloc.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_read.dart';

/// Adapts [LinkBloc] to the read-only network port Home uses.
class BlocLinkRead implements LinkRead {
  const BlocLinkRead(this._bloc);

  final LinkBloc _bloc;

  @override
  LinkPhase get phase => _bloc.state;

  @override
  Stream<LinkPhase> watch() => _bloc.stream;
}
