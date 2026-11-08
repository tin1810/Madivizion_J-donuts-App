import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_read.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';

sealed class HomeEvent {
  const HomeEvent();
}

/// Loads Drift, then refreshes in the background when the network is up.
final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

/// Pull-to-refresh. Offline keeps the rows already on screen.
final class HomeRefreshed extends HomeEvent {
  const HomeRefreshed();
}

final class _HomeSyncRequested extends HomeEvent {
  const _HomeSyncRequested();
}

sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeReady extends HomeState {
  const HomeReady(this.feed);

  final HomeFeed feed;
}

final class HomeFailure extends HomeState {
  const HomeFailure();
}

/// Paints from Drift. A refresh writes into Drift, then the screen reads again.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required CatalogRepository catalog, required LinkRead link})
    : _catalog = catalog,
      _link = link,
      super(const HomeLoading()) {
    on<HomeStarted>(_onStarted);
    on<HomeRefreshed>(_onRefreshed);
    on<_HomeSyncRequested>(_onSync);
  }

  final CatalogRepository _catalog;
  final LinkRead _link;
  StreamSubscription<LinkPhase>? _linkSub;
  var _syncing = false;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    await _showLocal(emit);
    _listenForNetwork();
    if (_link.phase == LinkPhase.online) {
      add(const _HomeSyncRequested());
    }
  }

  Future<void> _onRefreshed(
    HomeRefreshed event,
    Emitter<HomeState> emit,
  ) async {
    if (_link.phase == LinkPhase.online) {
      await _catalog.refresh();
    }
    await _showLocal(emit);
  }

  Future<void> _onSync(
    _HomeSyncRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (_syncing || _link.phase != LinkPhase.online) {
      return;
    }
    _syncing = true;
    final refreshed = await _catalog.refresh();
    _syncing = false;
    if (refreshed is! Success<Unit> || isClosed) {
      return;
    }
    await _showLocal(emit);
  }

  Future<void> _showLocal(Emitter<HomeState> emit) async {
    try {
      final feed = await _catalog.loadHome();
      if (!isClosed) {
        emit(HomeReady(feed));
      }
    } on Object {
      if (!isClosed) {
        emit(const HomeFailure());
      }
    }
  }

  void _listenForNetwork() {
    _linkSub ??= _link.watch().listen((phase) {
      if (phase == LinkPhase.online && !isClosed) {
        add(const _HomeSyncRequested());
      }
    });
  }

  @override
  Future<void> close() async {
    await _linkSub?.cancel();
    return super.close();
  }
}
