import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/month_parser.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/name_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/phone_validator.dart';

enum RegistrationPurpose { register, signIn }

enum RegistrationStep { phone, otp, name, birth }

enum RegistrationStatus { editing, submitting }

/// Draft kept for the whole phone-to-birth flow, including Back.
class RegistrationState {
  const RegistrationState({
    required this.purpose,
    this.step = RegistrationStep.phone,
    this.status = RegistrationStatus.editing,
    this.phoneRaw = '',
    this.phoneTouched = false,
    this.unknownAccount = false,
    this.alreadyRegistered = false,
    this.unavailable = false,
    this.otp = '',
    this.failedAttempts = 0,
    this.otpError,
    this.shake = 0,
    this.resendRemaining = OtpRules.resendWait,
    this.firstName = '',
    this.lastName = '',
    this.firstNameTouched = false,
    this.lastNameTouched = false,
    this.month = '',
    this.day = '',
    this.year = '',
    this.birthTouched = false,
    this.destination,
    this.userId,
  });

  final RegistrationPurpose purpose;
  final RegistrationStep step;
  final RegistrationStatus status;
  final String phoneRaw;
  final bool phoneTouched;
  final bool unknownAccount;
  final bool alreadyRegistered;
  final bool unavailable;
  final String otp;
  final int failedAttempts;
  final OtpRejection? otpError;
  final int shake;
  final Duration resendRemaining;
  final String firstName;
  final String lastName;
  final bool firstNameTouched;
  final bool lastNameTouched;
  final String month;
  final String day;
  final String year;
  final bool birthTouched;
  final String? destination;
  final String? userId;

  bool get submitting => status == RegistrationStatus.submitting;

  bool get phoneReady => validatePhone(phoneRaw) is ValidPhone;

  bool get otpLocked => failedAttempts >= OtpRules.maxAttempts;

  bool get nameReady {
    return validateFirstName(firstName) is ValidName &&
        validateLastName(lastName) is ValidName;
  }

  bool birthReady(DateTime today) => birthCheck(today) is ValidBirthDate;

  bool get ringChecked => step == RegistrationStep.birth;

  double get ringProgress {
    return switch (step) {
      RegistrationStep.phone => 0.25,
      RegistrationStep.otp => 0.5,
      RegistrationStep.name => 0.75,
      RegistrationStep.birth => 1,
    };
  }

  String get displayPhone {
    final check = validatePhone(phoneRaw);
    return check is ValidPhone ? check.e164 : phoneRaw;
  }

  NameRejection? get firstNameError => _nameError(
    touched: firstNameTouched,
    check: validateFirstName(firstName),
  );

  NameRejection? get lastNameError =>
      _nameError(touched: lastNameTouched, check: validateLastName(lastName));

  BirthDateCheck birthCheck(DateTime today) {
    return validateBirthDate(
      month: _number(month, parseMonth),
      day: _number(day, int.tryParse),
      year: _number(year, int.tryParse),
      today: today,
    );
  }

  RegistrationState copyWith({
    RegistrationPurpose? purpose,
    RegistrationStep? step,
    RegistrationStatus? status,
    String? phoneRaw,
    bool? phoneTouched,
    bool? unknownAccount,
    bool? alreadyRegistered,
    bool? unavailable,
    String? otp,
    int? failedAttempts,
    OtpRejection? otpError,
    bool clearOtpError = false,
    int? shake,
    Duration? resendRemaining,
    String? firstName,
    String? lastName,
    bool? firstNameTouched,
    bool? lastNameTouched,
    String? month,
    String? day,
    String? year,
    bool? birthTouched,
    String? destination,
    String? userId,
  }) {
    return RegistrationState(
      purpose: purpose ?? this.purpose,
      step: step ?? this.step,
      status: status ?? this.status,
      phoneRaw: phoneRaw ?? this.phoneRaw,
      phoneTouched: phoneTouched ?? this.phoneTouched,
      unknownAccount: unknownAccount ?? this.unknownAccount,
      alreadyRegistered: alreadyRegistered ?? this.alreadyRegistered,
      unavailable: unavailable ?? this.unavailable,
      otp: otp ?? this.otp,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      otpError: clearOtpError ? null : otpError ?? this.otpError,
      shake: shake ?? this.shake,
      resendRemaining: resendRemaining ?? this.resendRemaining,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      firstNameTouched: firstNameTouched ?? this.firstNameTouched,
      lastNameTouched: lastNameTouched ?? this.lastNameTouched,
      month: month ?? this.month,
      day: day ?? this.day,
      year: year ?? this.year,
      birthTouched: birthTouched ?? this.birthTouched,
      destination: destination ?? this.destination,
      userId: userId ?? this.userId,
    );
  }
}

NameRejection? _nameError({required bool touched, required NameCheck check}) {
  if (!touched || check is! InvalidName) {
    return null;
  }
  return check.reason;
}

int? _number(String raw, int? Function(String value) parse) {
  final text = raw.trim();
  if (text.isEmpty) {
    return null;
  }
  return parse(text) ?? 0;
}
