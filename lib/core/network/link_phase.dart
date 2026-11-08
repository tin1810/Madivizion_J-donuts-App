/// What the app has learned about the network.
enum LinkPhase { unknown, online, offline }

/// Online only when a network interface is up and a host answers.
LinkPhase decideLink({required bool interfaceUp, required bool reachable}) {
  if (!interfaceUp || !reachable) {
    return LinkPhase.offline;
  }
  return LinkPhase.online;
}
