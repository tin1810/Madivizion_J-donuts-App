import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_read.dart';
import 'package:madivizion_jdonuts_app/features/home/data/memory_catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/presentation/home_bloc.dart';

void main() {
  test('an online start refreshes, then home reads the local feed', () async {
    final catalog = MemoryCatalogRepository();
    final bloc = HomeBloc(
      catalog: catalog,
      link: _ScriptLink(LinkPhase.online),
    );
    final states = expectLater(
      bloc.stream,
      emitsInOrder([isA<HomeReady>(), isA<HomeReady>()]),
    );

    bloc.add(const HomeStarted());
    await states;

    expect(catalog.refreshCount, 1);
    await bloc.close();
  });

  test('offline keeps the local rows and skips refresh', () async {
    final catalog = MemoryCatalogRepository();
    final bloc = HomeBloc(
      catalog: catalog,
      link: _ScriptLink(LinkPhase.offline),
    );

    bloc.add(const HomeStarted());
    await bloc.stream.first;
    expect(catalog.refreshCount, 0);

    bloc.add(const HomeRefreshed());
    await bloc.stream.first;
    expect(catalog.refreshCount, 0);
    await bloc.close();
  });

  test('coming back online refreshes in the background', () async {
    final catalog = MemoryCatalogRepository();
    final link = _ScriptLink(LinkPhase.offline);
    final bloc = HomeBloc(catalog: catalog, link: link);
    bloc.add(const HomeStarted());
    await bloc.stream.first;

    link.phase = LinkPhase.online;
    link.changes.add(LinkPhase.online);
    await bloc.stream.first;

    expect(catalog.refreshCount, 1);
    await bloc.close();
    await link.changes.close();
  });
}

class _ScriptLink implements LinkRead {
  _ScriptLink(this.phase);

  @override
  LinkPhase phase;

  final changes = StreamController<LinkPhase>.broadcast();

  @override
  Stream<LinkPhase> watch() => changes.stream;
}
