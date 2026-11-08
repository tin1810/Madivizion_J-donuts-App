import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';

void main() {
  test('the fake code 123456 is accepted', () {
    final result = validateOtp(code: OtpRules.acceptedCode, failedAttempts: 0);

    expect(result, const OtpAccepted());
  });

  test('a different six digit code is rejected and counted', () {
    final result = validateOtp(code: '000000', failedAttempts: 0);

    expect(
      result,
      const OtpRejected(
        reason: OtpRejection.incorrect,
        failedAttempts: 1,
      ),
    );
  });

  test('the fake code still passes after two wrong codes', () {
    final result = validateOtp(code: OtpRules.acceptedCode, failedAttempts: 2);

    expect(result, const OtpAccepted());
  });

  test('the third wrong code locks entry', () {
    final result = validateOtp(code: '000000', failedAttempts: 2);

    expect(
      result,
      const OtpRejected(
        reason: OtpRejection.locked,
        failedAttempts: 3,
      ),
    );
  });

  test('a later code stays locked until resend resets the count', () {
    final result = validateOtp(code: OtpRules.acceptedCode, failedAttempts: 3);

    expect(
      result,
      const OtpRejected(
        reason: OtpRejection.locked,
        failedAttempts: 3,
      ),
    );
  });

  test('fewer than six digits does not count as a wrong code', () {
    final result = validateOtp(code: '12345', failedAttempts: 1);

    expect(
      result,
      const OtpRejected(
        reason: OtpRejection.incomplete,
        failedAttempts: 1,
      ),
    );
  });

  test('letters are not a six digit code', () {
    final result = validateOtp(code: '12345a', failedAttempts: 0);

    expect(
      result,
      const OtpRejected(
        reason: OtpRejection.incomplete,
        failedAttempts: 0,
      ),
    );
  });
}
