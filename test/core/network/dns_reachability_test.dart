import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/network/dns_reachability.dart';

void main() {
  test('a host that answers is reachable', () async {
    final reachability = DnsReachability(
      lookup: (_) async => [InternetAddress.loopbackIPv4],
    );

    expect(await reachability.canReach, isTrue);
  });

  test('a failed lookup is not reachable', () async {
    final reachability = DnsReachability(
      lookup: (_) async => throw const SocketException('down'),
    );

    expect(await reachability.canReach, isFalse);
  });

  test('an empty lookup is not reachable', () async {
    final reachability = DnsReachability(lookup: (_) async => []);

    expect(await reachability.canReach, isFalse);
  });
}
