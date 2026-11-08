import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

/// Local account store and session. The fake implementation waits about
/// one second on account lookups and registration.
abstract interface class AuthRepository {
  Future<Result<UserAccount?>> findByPhone(String phoneE164);

  Future<Result<UserAccount>> register(UserAccount account);

  Future<Result<Unit>> saveSession(String userId);

  Future<Result<String?>> readSession();

  Future<Result<Unit>> clearSession();
}
