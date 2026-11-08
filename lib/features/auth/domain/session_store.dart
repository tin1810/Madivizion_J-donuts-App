import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';

/// Persists the signed-in user id across relaunch.
abstract interface class SessionStore {
  Future<Result<String?>> read();

  Future<Result<Unit>> write(String userId);

  Future<Result<Unit>> clear();
}
