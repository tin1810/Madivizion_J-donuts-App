import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/sign_in.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

import '../memory_auth_repository.dart';

void main() {
  const phone = '09254135592';
  final account = UserAccount(
    phoneE164: '+959254135592',
    firstName: 'Ye Min',
    lastName: 'Phyo Win',
    birthDate: DateTime(1980, 5, 1),
  );

  Future<MemoryAuthRepository> storedAccount() async {
    final repository = MemoryAuthRepository();
    await repository.register(account);
    await repository.clearSession();
    return repository;
  }

  test('an unknown number does not start a session', () async {
    final signIn = SignIn(MemoryAuthRepository());

    final result = await signIn(
      phoneRaw: phone,
      code: OtpRules.acceptedCode,
      failedAttempts: 0,
    );

    expect(result, const Failure<UserAccount>(UnknownAccountFailure()));
  });

  test('the fake code signs in a stored account', () async {
    final repository = await storedAccount();
    final signIn = SignIn(repository);

    final result = await signIn(
      phoneRaw: phone,
      code: OtpRules.acceptedCode,
      failedAttempts: 0,
    );

    expect(result, Success(account));
    expect(
      await repository.readSession(),
      const Success<String?>('+959254135592'),
    );
  });

  test('a wrong code is counted', () async {
    final signIn = SignIn(await storedAccount());

    final result = await signIn(
      phoneRaw: phone,
      code: '000000',
      failedAttempts: 0,
    );

    expect(
      result,
      const Failure<UserAccount>(
        InvalidOtpFailure(
          reason: OtpRejection.incorrect,
          failedAttempts: 1,
        ),
      ),
    );
  });

  test('the third wrong code locks sign in', () async {
    final signIn = SignIn(await storedAccount());

    final result = await signIn(
      phoneRaw: phone,
      code: '000000',
      failedAttempts: 2,
    );

    expect(
      result,
      const Failure<UserAccount>(
        InvalidOtpFailure(
          reason: OtpRejection.locked,
          failedAttempts: 3,
        ),
      ),
    );
  });
}
