import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/register_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/sign_in.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';

import '../memory_auth_repository.dart';

void main() {
  const today = _Today();

  RegistrationBloc open({
    RegistrationPurpose purpose = RegistrationPurpose.register,
    MemoryAuthRepository? repository,
    Duration delay = Duration.zero,
  }) {
    final accounts = repository ?? MemoryAuthRepository();
    final bloc = RegistrationBloc(
      purpose: purpose,
      repository: accounts,
      signIn: SignIn(accounts),
      registerAccount: RegisterAccount(accounts, clock: today.call),
      ticker: const _SilentTicker(),
      pacing: AuthPacing(delay: delay),
      clock: today.call,
    );
    addTearDown(bloc.close);
    return bloc;
  }

  test('an invalid phone does not leave the step', () async {
    final bloc = open();

    bloc.add(const PhoneChanged('123'));
    bloc.add(const PhoneSubmitted());

    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<RegistrationState>()
            .having((state) => state.step, 'step', RegistrationStep.phone)
            .having((state) => state.phoneTouched, 'touched', isTrue),
      ),
    );
  });

  test('a new number opens the OTP step', () async {
    final bloc = open();
    bloc.add(const PhoneChanged('09254135592'));
    bloc.add(const PhoneSubmitted());

    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<RegistrationState>().having(
          (state) => state.step,
          'step',
          RegistrationStep.otp,
        ),
      ),
    );
  });

  test('an unknown number stays on sign in', () async {
    final bloc = open(purpose: RegistrationPurpose.signIn);
    bloc.add(const PhoneChanged('09254135592'));
    bloc.add(const PhoneSubmitted());

    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<RegistrationState>().having(
          (state) => state.unknownAccount,
          'unknown',
          isTrue,
        ),
      ),
    );
  });

  test('a wrong code is cleared and counted', () async {
    final bloc = open();
    await _openOtp(bloc);

    bloc.add(const OtpChanged('000000'));

    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<RegistrationState>()
            .having((state) => state.otp, 'otp', isEmpty)
            .having((state) => state.failedAttempts, 'attempts', 1)
            .having((state) => state.otpError, 'error', OtpRejection.incorrect),
      ),
    );
  });

  test('the third wrong code locks entry until resend', () async {
    final bloc = open();
    await _openOtp(bloc);
    bloc.add(const OtpChanged('000000'));
    await bloc.stream.firstWhere((state) => state.failedAttempts == 1);
    bloc.add(const OtpChanged('000000'));
    await bloc.stream.firstWhere((state) => state.failedAttempts == 2);

    bloc.add(const OtpChanged('000000'));
    await bloc.stream.firstWhere((state) => state.otpLocked);

    bloc.add(const OtpChanged('123456'));
    await pumpEventQueue();
    expect(bloc.state.otpLocked, isTrue);
    expect(bloc.state.step, RegistrationStep.otp);

    bloc.add(const RegistrationCountdownTicked(Duration.zero));
    bloc.add(const ResendPressed());
    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<RegistrationState>().having(
          (state) => state.failedAttempts,
          'attempts',
          0,
        ),
      ),
    );
  });

  test('back keeps the name that was typed', () async {
    final bloc = open();
    await _openOtp(bloc);
    bloc.add(const OtpChanged(OtpRules.acceptedCode));
    await bloc.stream.firstWhere(
      (state) => state.step == RegistrationStep.name,
    );
    bloc.add(const FirstNameChanged('Ye Min'));
    bloc.add(const NameSubmitted());
    await bloc.stream.firstWhere(
      (state) => state.step == RegistrationStep.birth,
    );

    bloc.add(const RegistrationBackPressed());
    await expectLater(
      bloc.stream,
      emits(
        isA<RegistrationState>()
            .having((state) => state.step, 'step', RegistrationStep.name)
            .having((state) => state.firstName, 'name', 'Ye Min'),
      ),
    );
  });

  test('31 April does not finish registration', () async {
    final bloc = open();
    await _readyToRegister(bloc);
    bloc.add(const BirthMonthChanged('April'));
    bloc.add(const BirthDayChanged('31'));
    bloc.add(const BirthYearChanged('1980'));
    bloc.add(const BirthSubmitted());

    await expectLater(
      bloc.stream,
      emitsThrough(
        isA<RegistrationState>()
            .having((state) => state.step, 'step', RegistrationStep.birth)
            .having((state) => state.birthTouched, 'touched', isTrue)
            .having((state) => state.destination, 'destination', isNull),
      ),
    );
  });

  test('a second tap does not register twice', () async {
    final accounts = _CountingRepository();
    final bloc = open(repository: accounts);
    await _readyToRegister(bloc);

    bloc.add(const BirthSubmitted());
    bloc.add(const BirthSubmitted());
    await bloc.stream.firstWhere(
      (state) => state.destination == AppRoutes.welcome,
    );

    expect(accounts.registrations, 1);
    expect(bloc.state.userId, '+959254135592');
  });
}

Future<void> _openOtp(RegistrationBloc bloc) async {
  bloc.add(const PhoneChanged('09254135592'));
  bloc.add(const PhoneSubmitted());
  await bloc.stream.firstWhere((state) => state.step == RegistrationStep.otp);
}

Future<void> _readyToRegister(RegistrationBloc bloc) async {
  await _openOtp(bloc);
  bloc.add(const OtpChanged(OtpRules.acceptedCode));
  await bloc.stream.firstWhere((state) => state.step == RegistrationStep.name);
  bloc.add(const FirstNameChanged('Ye Min'));
  bloc.add(const LastNameChanged('Phyo Win'));
  bloc.add(const NameSubmitted());
  await bloc.stream.firstWhere((state) => state.step == RegistrationStep.birth);
  bloc.add(const BirthMonthChanged('May'));
  bloc.add(const BirthDayChanged('01'));
  bloc.add(const BirthYearChanged('1980'));
}

class _Today {
  const _Today();

  DateTime call() => DateTime(2026, 11, 8);
}

class _SilentTicker extends SecondTicker {
  const _SilentTicker();

  @override
  Stream<int> countdown(int from) => const Stream<int>.empty();
}

class _CountingRepository extends MemoryAuthRepository {
  _CountingRepository() : super(delay: const Duration(milliseconds: 40));

  int registrations = 0;

  @override
  Future<Result<UserAccount>> register(UserAccount account) async {
    registrations += 1;
    return super.register(account);
  }
}
