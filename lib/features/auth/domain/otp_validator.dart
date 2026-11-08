/// Fake OTP rules for registration and login.
abstract final class OtpRules {
  static const String acceptedCode = '123456';
  static const int length = 6;
  static const int maxAttempts = 3;
  static const Duration resendWait = Duration(minutes: 5);
}

/// Outcome of checking one OTP entry.
sealed class OtpCheck {
  const OtpCheck(this.failedAttempts);

  final int failedAttempts;
}

/// [OtpRules.acceptedCode] was entered before the lockout.
final class OtpAccepted extends OtpCheck {
  const OtpAccepted() : super(0);
}

/// Why an OTP entry cannot continue.
enum OtpRejection { incomplete, incorrect, locked }

/// The code was incomplete, wrong, or entry is locked until resend.
final class OtpRejected extends OtpCheck {
  const OtpRejected({required this.reason, required int failedAttempts})
    : super(failedAttempts);

  final OtpRejection reason;

  @override
  bool operator ==(Object other) {
    return other is OtpRejected &&
        other.reason == reason &&
        other.failedAttempts == failedAttempts;
  }

  @override
  int get hashCode => Object.hash(reason, failedAttempts);
}

final RegExp _otpDigits = RegExp('^\\d{${OtpRules.length}}\$');

/// Accepts only [OtpRules.acceptedCode]. The third wrong code locks entry.
OtpCheck validateOtp({required String code, required int failedAttempts}) {
  if (failedAttempts >= OtpRules.maxAttempts) {
    return OtpRejected(
      reason: OtpRejection.locked,
      failedAttempts: failedAttempts,
    );
  }
  if (!_otpDigits.hasMatch(code)) {
    return OtpRejected(
      reason: OtpRejection.incomplete,
      failedAttempts: failedAttempts,
    );
  }
  if (code == OtpRules.acceptedCode) {
    return const OtpAccepted();
  }
  return _rejectWrongCode(failedAttempts);
}

OtpRejected _rejectWrongCode(int failedAttempts) {
  final nextAttempt = failedAttempts + 1;
  final locked = nextAttempt >= OtpRules.maxAttempts;
  return OtpRejected(
    reason: locked ? OtpRejection.locked : OtpRejection.incorrect,
    failedAttempts: nextAttempt,
  );
}
