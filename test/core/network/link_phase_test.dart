import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/connectivity/link_bloc.dart';
import 'package:madivizion_jdonuts_app/core/network/link_phase.dart';
import 'package:madivizion_jdonuts_app/core/network/link_watch.dart';

void main() {
  test('an interface without a reachable host is offline', () {
    expect(decideLink(interfaceUp: true, reachable: false), LinkPhase.offline);
    expect(decideLink(interfaceUp: false, reachable: true), LinkPhase.offline);
  });

  test('an interface that can reach a host is online', () {
    expect(decideLink(interfaceUp: true, reachable: true), LinkPhase.online);
  });

  test('the link bloc reports an unreachable network', () async {
    final bloc = LinkBloc(const FixedLinkWatch(LinkPhase.offline));
    final shown = expectLater(bloc.stream, emits(LinkPhase.offline));

    bloc.add(const LinkStarted());

    await shown;
    await bloc.close();
  });
}
