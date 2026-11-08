sealed class RegistrationEvent {
  const RegistrationEvent();
}

final class PhoneChanged extends RegistrationEvent {
  const PhoneChanged(this.value);

  final String value;
}

final class PhoneBlurred extends RegistrationEvent {
  const PhoneBlurred();
}

final class PhoneSubmitted extends RegistrationEvent {
  const PhoneSubmitted();
}

final class OtpChanged extends RegistrationEvent {
  const OtpChanged(this.value);

  final String value;
}

final class OtpSubmitted extends RegistrationEvent {
  const OtpSubmitted();
}

final class ResendPressed extends RegistrationEvent {
  const ResendPressed();
}

final class RegistrationCountdownTicked extends RegistrationEvent {
  const RegistrationCountdownTicked(this.remaining);

  final Duration remaining;
}

final class FirstNameChanged extends RegistrationEvent {
  const FirstNameChanged(this.value);

  final String value;
}

final class LastNameChanged extends RegistrationEvent {
  const LastNameChanged(this.value);

  final String value;
}

final class FirstNameBlurred extends RegistrationEvent {
  const FirstNameBlurred();
}

final class LastNameBlurred extends RegistrationEvent {
  const LastNameBlurred();
}

final class NameSubmitted extends RegistrationEvent {
  const NameSubmitted();
}

final class BirthMonthChanged extends RegistrationEvent {
  const BirthMonthChanged(this.value);

  final String value;
}

final class BirthDayChanged extends RegistrationEvent {
  const BirthDayChanged(this.value);

  final String value;
}

final class BirthYearChanged extends RegistrationEvent {
  const BirthYearChanged(this.value);

  final String value;
}

final class BirthBlurred extends RegistrationEvent {
  const BirthBlurred();
}

final class BirthSubmitted extends RegistrationEvent {
  const BirthSubmitted();
}

final class RegistrationBackPressed extends RegistrationEvent {
  const RegistrationBackPressed();
}

final class SwitchToRegister extends RegistrationEvent {
  const SwitchToRegister();
}

final class SwitchToSignIn extends RegistrationEvent {
  const SwitchToSignIn();
}
