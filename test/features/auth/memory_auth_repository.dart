import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

/// In-memory store used by use-case tests.
class MemoryAuthRepository implements AuthRepository {
  MemoryAuthRepository({this.delay = Duration.zero});

  final Duration delay;
  final Map<String, UserAccount> _users = {};
  String? _session;

  @override
  Future<Result<UserAccount?>> findByPhone(String phoneE164) async {
    await Future<void>.delayed(delay);
    return Success(_users[phoneE164]);
  }

  @override
  Future<Result<UserAccount>> register(UserAccount account) async {
    await Future<void>.delayed(delay);
    if (_users.containsKey(account.phoneE164)) {
      return const Failure(AccountAlreadyExistsFailure());
    }
    _users[account.phoneE164] = account;
    return Success(account);
  }

  @override
  Future<Result<Unit>> saveSession(String userId) async {
    _session = userId;
    return const Success(Unit.instance);
  }

  @override
  Future<Result<String?>> readSession() async => Success(_session);

  @override
  Future<Result<Unit>> clearSession() async {
    _session = null;
    return const Success(Unit.instance);
  }
}
