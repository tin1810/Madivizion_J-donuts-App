import 'dart:io';

import 'package:madivizion_jdonuts_app/core/network/reachability.dart';

/// Looks up [host]. A failure, including a timeout, means the network is down.
class DnsReachability implements Reachability {
  const DnsReachability({
    this.host = 'example.com',
    this.lookup = InternetAddress.lookup,
    this.timeout = const Duration(seconds: 2),
  });

  final String host;
  final Lookup lookup;
  final Duration timeout;

  @override
  Future<bool> get canReach async {
    try {
      final found = await lookup(host).timeout(timeout);
      if (found.isEmpty) {
        return false;
      }
      return found.first.rawAddress.isNotEmpty;
    } on Object {
      return false;
    }
  }
}

typedef Lookup = Future<List<InternetAddress>> Function(String host);
