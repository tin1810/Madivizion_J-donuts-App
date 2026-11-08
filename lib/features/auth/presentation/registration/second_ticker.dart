/// One-second countdown used by the OTP resend timer.
class SecondTicker {
  const SecondTicker();

  Stream<int> countdown(int from) {
    return Stream<int>.periodic(
      const Duration(seconds: 1),
      (tick) => from - tick - 1,
    ).take(from);
  }
}
