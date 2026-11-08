import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/session_store.dart';

/// Key for the signed-in phone number.
abstract final class SessionKeys {
  static const String userId = 'session_user_id';
}

/// Session kept in the platform secure store.
class SecureSessionStore implements SessionStore {
  const SecureSessionStore(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<Result<String?>> read() {
    return Result.capture(() => _storage.read(key: SessionKeys.userId));
  }

  @override
  Future<Result<Unit>> write(String userId) {
    return Result.capture(() async {
      await _storage.write(key: SessionKeys.userId, value: userId);
      return Unit.instance;
    });
  }

  @override
  Future<Result<Unit>> clear() {
    return Result.capture(() async {
      await _storage.delete(key: SessionKeys.userId);
      return Unit.instance;
    });
  }
}
