/// A real check that some host answers, beyond "an interface is up".
abstract class Reachability {
  const Reachability();

  Future<bool> get canReach;
}
