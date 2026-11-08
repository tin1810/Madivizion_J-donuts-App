import 'package:madivizion_jdonuts_app/core/error/app_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/name_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';

/// The phone number does not match the Myanmar mobile rule.
final class InvalidPhoneFailure extends AppFailure {
  const InvalidPhoneFailure();
}

/// A name field failed [reason].
final class InvalidNameFailure extends AppFailure {
  const InvalidNameFailure(this.reason);

  final NameRejection reason;

  @override
  bool operator ==(Object other) {
    return other is InvalidNameFailure && other.reason == reason;
  }

  @override
  int get hashCode => reason.hashCode;
}

/// A date of birth failed [reason].
final class InvalidBirthDateFailure extends AppFailure {
  const InvalidBirthDateFailure(this.reason);

  final BirthDateRejection reason;

  @override
  bool operator ==(Object other) {
    return other is InvalidBirthDateFailure && other.reason == reason;
  }

  @override
  int get hashCode => reason.hashCode;
}

/// The OTP was incomplete, wrong, or entry is locked.
final class InvalidOtpFailure extends AppFailure {
  const InvalidOtpFailure({
    required this.reason,
    required this.failedAttempts,
  });

  final OtpRejection reason;
  final int failedAttempts;

  @override
  bool operator ==(Object other) {
    return other is InvalidOtpFailure &&
        other.reason == reason &&
        other.failedAttempts == failedAttempts;
  }

  @override
  int get hashCode => Object.hash(reason, failedAttempts);
}

/// Login was attempted with a number that has never registered.
final class UnknownAccountFailure extends AppFailure {
  const UnknownAccountFailure();
}

/// Registration was attempted with a phone that is already stored.
final class AccountAlreadyExistsFailure extends AppFailure {
  const AccountAlreadyExistsFailure();
}
