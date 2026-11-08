import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/app_database.dart';
import 'package:madivizion_jdonuts_app/features/auth/data/drift_auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

import '../memory_session_store.dart';

void main() {
  late AppDatabase database;
  late DriftAuthRepository repository;
  final account = UserAccount(
    phoneE164: '+959254135592',
    firstName: 'Ye Min',
    lastName: 'Phyo Win',
    birthDate: DateTime(1980, 5, 1),
  );

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftAuthRepository(
      database: database,
      sessionStore: MemorySessionStore(),
      delay: Duration.zero,
    );
  });

  tearDown(() => database.close());

  test('schema version 2 still stores and reads an account', () async {
    expect(database.schemaVersion, 2);

    final registered = await repository.register(account);
    final found = await repository.findByPhone(account.phoneE164);

    expect(registered, Success<UserAccount>(account));
    expect(found, Success<UserAccount?>(account));
  });

  test('registering the same phone twice is rejected', () async {
    await repository.register(account);

    final again = await repository.register(account);

    expect(again, const Failure<UserAccount>(AccountAlreadyExistsFailure()));
  });

  test('register waits for the configured fake delay', () async {
    final slow = DriftAuthRepository(
      database: database,
      sessionStore: MemorySessionStore(),
      delay: const Duration(milliseconds: 40),
    );
    final started = DateTime.now();

    await slow.register(account);

    final elapsed = DateTime.now().difference(started);
    expect(elapsed.inMilliseconds >= 40, isTrue);
  });
}
