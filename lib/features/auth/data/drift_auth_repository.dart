import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/session_store.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

/// Stores accounts in Drift and the session in [SessionStore].
class DriftAuthRepository implements AuthRepository {
  DriftAuthRepository({
    required AppDatabase database,
    required SessionStore sessionStore,
    this.delay = AuthTiming.fakeDelay,
  }) : _database = database,
       _sessionStore = sessionStore;

  final AppDatabase _database;
  final SessionStore _sessionStore;
  final Duration delay;

  @override
  Future<Result<UserAccount?>> findByPhone(String phoneE164) {
    return Result.capture(() async {
      await _wait();
      final row = await _row(phoneE164);
      return row == null ? null : _account(row);
    });
  }

  @override
  Future<Result<UserAccount>> register(UserAccount account) {
    return Result.capture(() async {
      await _wait();
      final existing = await _row(account.phoneE164);
      if (existing != null) {
        throw const AccountAlreadyExistsFailure();
      }
      await _database
          .into(_database.storedUsers)
          .insert(_companion(account));
      return account;
    });
  }

  @override
  Future<Result<Unit>> saveSession(String userId) {
    return _sessionStore.write(userId);
  }

  @override
  Future<Result<String?>> readSession() => _sessionStore.read();

  @override
  Future<Result<Unit>> clearSession() => _sessionStore.clear();

  Future<void> _wait() => Future<void>.delayed(delay);

  Future<StoredUser?> _row(String phoneE164) {
    return (_database.select(_database.storedUsers)
          ..where((row) => row.phoneE164.equals(phoneE164)))
        .getSingleOrNull();
  }

  StoredUsersCompanion _companion(UserAccount account) {
    return StoredUsersCompanion.insert(
      phoneE164: account.phoneE164,
      firstName: account.firstName,
      lastName: account.lastName,
      birthDate: _formatDate(account.birthDate),
    );
  }

  UserAccount _account(StoredUser row) {
    return UserAccount(
      phoneE164: row.phoneE164,
      firstName: row.firstName,
      lastName: row.lastName,
      birthDate: _parseDate(row.birthDate),
    );
  }
}

String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

DateTime _parseDate(String value) {
  final parts = value.split('-');
  return DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
  );
}
