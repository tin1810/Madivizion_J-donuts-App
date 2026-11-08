import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_watch.dart';

sealed class LinkEvent {
  const LinkEvent();
}

/// Starts listening for network changes.
final class LinkStarted extends LinkEvent {
  const LinkStarted();
}

final class _LinkUpdated extends LinkEvent {
  const _LinkUpdated(this.phase);

  final LinkPhase phase;
}

/// Holds the latest [LinkPhase]. It starts unknown, so the banner waits.
class LinkBloc extends Bloc<LinkEvent, LinkPhase> {
  LinkBloc(this._watch) : super(LinkPhase.unknown) {
    on<LinkStarted>(_onStarted);
    on<_LinkUpdated>(_onUpdated);
  }

  final LinkWatch _watch;
  StreamSubscription<LinkPhase>? _subscription;

  Future<void> _onStarted(LinkStarted event, Emitter<LinkPhase> emit) async {
    await _subscription?.cancel();
    _subscription = _watch.watch().listen(
      (phase) => add(_LinkUpdated(phase)),
      onError: (_) => add(const _LinkUpdated(LinkPhase.offline)),
    );
  }

  void _onUpdated(_LinkUpdated event, Emitter<LinkPhase> emit) {
    if (event.phase != state) {
      emit(event.phase);
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
