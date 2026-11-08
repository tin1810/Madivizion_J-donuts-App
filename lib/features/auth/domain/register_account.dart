import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/name_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/phone_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';

/// Fields collected across registration.
class RegisterAccountInput {
  const RegisterAccountInput({
    required this.phoneRaw,
    required this.firstName,
    required this.lastName,
    required this.month,
    required this.day,
    required this.year,
  });

  final String phoneRaw;
  final String firstName;
  final String lastName;
  final int? month;
  final int? day;
  final int? year;
}

/// Validates registration, stores the account, and starts a session.
class RegisterAccount {
  RegisterAccount(this._repository, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final AuthRepository _repository;
  final DateTime Function() _clock;

  Future<Result<UserAccount>> call(RegisterAccountInput input) async {
    final built = _buildAccount(input, _clock());
    if (built case Failure()) {
      return built;
    }
    final account = (built as Success<UserAccount>).value;
    final registered = await _repository.register(account);
    if (registered case Failure()) {
      return registered;
    }
    final saved = await _repository.saveSession(account.phoneE164);
    if (saved case Failure(:final failure)) {
      return Failure(failure);
    }
    return Success(account);
  }
}

Result<UserAccount> _buildAccount(RegisterAccountInput input, DateTime today) {
  final phone = validatePhone(input.phoneRaw);
  if (phone is! ValidPhone) {
    return const Failure(InvalidPhoneFailure());
  }
  final firstName = _requiredName(validateFirstName(input.firstName));
  if (firstName is Failure<String>) {
    return Failure(firstName.failure);
  }
  final lastName = _requiredName(validateLastName(input.lastName));
  if (lastName is Failure<String>) {
    return Failure(lastName.failure);
  }
  final birth = validateBirthDate(
    month: input.month,
    day: input.day,
    year: input.year,
    today: today,
  );
  if (birth is InvalidBirthDate) {
    return Failure(InvalidBirthDateFailure(birth.reason));
  }
  return Success(
    UserAccount(
      phoneE164: phone.e164,
      firstName: (firstName as Success<String>).value,
      lastName: (lastName as Success<String>).value,
      birthDate: (birth as ValidBirthDate).date,
    ),
  );
}

Result<String> _requiredName(NameCheck check) {
  if (check is InvalidName) {
    return Failure(InvalidNameFailure(check.reason));
  }
  return Success((check as ValidName).value);
}
