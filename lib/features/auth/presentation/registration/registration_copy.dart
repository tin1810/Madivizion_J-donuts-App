import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/name_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

String? phoneMessage(AppLocalizations l10n, RegistrationState state) {
  if (state.unknownAccount) {
    return null;
  }
  if (state.alreadyRegistered) {
    return null;
  }
  if (state.unavailable && state.step == RegistrationStep.phone) {
    return l10n.phoneUnavailable;
  }
  if (state.phoneTouched && !state.phoneReady) {
    return l10n.phoneInvalid;
  }
  return null;
}

String? nameMessage(AppLocalizations l10n, NameRejection? reason) {
  return switch (reason) {
    null => null,
    NameRejection.required => l10n.nameRequired,
    NameRejection.tooLong => l10n.nameTooLong,
    NameRejection.invalidCharacters => l10n.nameInvalid,
  };
}

String? birthMessage(AppLocalizations l10n, RegistrationState state) {
  if (!state.birthTouched) {
    return null;
  }
  if (state.unavailable && state.step == RegistrationStep.birth) {
    return l10n.phoneUnavailable;
  }
  final check = state.birthCheck(DateTime.now());
  if (check is! InvalidBirthDate) {
    return null;
  }
  return switch (check.reason) {
    BirthDateRejection.incomplete => l10n.birthIncomplete,
    BirthDateRejection.impossible => l10n.birthImpossible,
    BirthDateRejection.inTheFuture => l10n.birthFuture,
    BirthDateRejection.tooYoung => l10n.birthTooYoung,
  };
}

String? otpMessage(AppLocalizations l10n, RegistrationState state) {
  return switch (state.otpError) {
    null => state.unavailable ? l10n.phoneUnavailable : null,
    OtpRejection.incomplete => null,
    OtpRejection.incorrect => l10n.otpIncorrect,
    OtpRejection.locked => l10n.otpLocked,
  };
}

String formatResend(Duration remaining) {
  final minutes = remaining.inMinutes;
  final seconds = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
