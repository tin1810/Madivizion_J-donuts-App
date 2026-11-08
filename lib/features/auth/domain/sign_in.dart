import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/phone_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

/// Signs in a stored account when the fake OTP passes.
class SignIn {
  const SignIn(this._repository);

  final AuthRepository _repository;

  Future<Result<UserAccount>> call({
    required String phoneRaw,
    required String code,
    required int failedAttempts,
  }) async {
    final phone = validatePhone(phoneRaw);
    if (phone is! ValidPhone) {
      return const Failure(InvalidPhoneFailure());
    }
    final found = await _repository.findByPhone(phone.e164);
    final account = _account(found);
    if (account is Failure<UserAccount>) {
      return account;
    }
    final otp = validateOtp(code: code, failedAttempts: failedAttempts);
    if (otp is OtpRejected) {
      return Failure(
        InvalidOtpFailure(
          reason: otp.reason,
          failedAttempts: otp.failedAttempts,
        ),
      );
    }
    final user = (account as Success<UserAccount>).value;
    final saved = await _repository.saveSession(user.phoneE164);
    if (saved case Failure(:final failure)) {
      return Failure(failure);
    }
    return Success(user);
  }
}

Result<UserAccount> _account(Result<UserAccount?> found) {
  return switch (found) {
    Failure(:final failure) => Failure(failure),
    Success(value: null) => const Failure(UnknownAccountFailure()),
    Success(value: final user?) => Success(user),
  };
}
