import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/session_store.dart';

/// Session store that stays in memory for database tests.
class MemorySessionStore implements SessionStore {
  String? _userId;

  @override
  Future<Result<String?>> read() async => Success(_userId);

  @override
  Future<Result<Unit>> write(String userId) async {
    _userId = userId;
    return const Success(Unit.instance);
  }

  @override
  Future<Result<Unit>> clear() async {
    _userId = null;
    return const Success(Unit.instance);
  }
}
