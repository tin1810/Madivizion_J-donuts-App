import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/name_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/register_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

import '../memory_auth_repository.dart';

void main() {
  const today = _FixedClock();
  final input = RegisterAccountInput(
    phoneRaw: '09254135592',
    firstName: 'Ye Min',
    lastName: 'Phyo Win',
    month: 5,
    day: 1,
    year: 1980,
  );

  test('register stores the account and starts a session', () async {
    final repository = MemoryAuthRepository();
    final register = RegisterAccount(
      repository,
      clock: today.call,
    );

    final result = await register(input);

    expect(
      result,
      Success(
        UserAccount(
          phoneE164: '+959254135592',
          firstName: 'Ye Min',
          lastName: 'Phyo Win',
          birthDate: DateTime(1980, 5, 1),
        ),
      ),
    );
    final session = await repository.readSession();
    expect(session, const Success<String?>('+959254135592'));
  });

  test('register rejects an empty first name', () async {
    final register = RegisterAccount(
      MemoryAuthRepository(),
      clock: today.call,
    );

    final result = await register(
      RegisterAccountInput(
        phoneRaw: input.phoneRaw,
        firstName: ' ',
        lastName: input.lastName,
        month: input.month,
        day: input.day,
        year: input.year,
      ),
    );

    expect(
      result,
      const Failure<UserAccount>(InvalidNameFailure(NameRejection.required)),
    );
  });

  test('register rejects 31 April', () async {
    final register = RegisterAccount(
      MemoryAuthRepository(),
      clock: today.call,
    );

    final result = await register(
      RegisterAccountInput(
        phoneRaw: input.phoneRaw,
        firstName: input.firstName,
        lastName: input.lastName,
        month: 4,
        day: 31,
        year: 1980,
      ),
    );

    expect(
      result,
      const Failure<UserAccount>(
        InvalidBirthDateFailure(BirthDateRejection.impossible),
      ),
    );
  });

  test('register rejects a phone that is already stored', () async {
    final repository = MemoryAuthRepository();
    final register = RegisterAccount(repository, clock: today.call);
    await register(input);

    final result = await register(input);

    expect(
      result,
      const Failure<UserAccount>(AccountAlreadyExistsFailure()),
    );
  });
}

class _FixedClock {
  const _FixedClock();

  DateTime call() => DateTime(2026, 11, 8);
}
