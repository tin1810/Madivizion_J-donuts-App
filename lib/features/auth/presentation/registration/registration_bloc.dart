import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:madivizion_jdonuts_app/app/router/app_routes.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_failure.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/birth_date_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/otp_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/phone_validator.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/register_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/sign_in.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_event.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';

/// Phone, OTP, name, and date of birth for one registration or sign-in.
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({
    required RegistrationPurpose purpose,
    required AuthRepository repository,
    required SignIn signIn,
    required RegisterAccount registerAccount,
    required SecondTicker ticker,
    required AuthPacing pacing,
    DateTime Function()? clock,
  }) : _repository = repository,
       _signIn = signIn,
       _registerAccount = registerAccount,
       _ticker = ticker,
       _pacing = pacing,
       _clock = clock ?? DateTime.now,
       super(RegistrationState(purpose: purpose)) {
    on<PhoneChanged>(_onPhoneChanged);
    on<PhoneBlurred>(_onPhoneBlurred);
    on<PhoneSubmitted>(_onPhoneSubmitted);
    on<OtpChanged>(_onOtpChanged);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<ResendPressed>(_onResend);
    on<RegistrationCountdownTicked>(_onTick);
    on<FirstNameChanged>(_onFirstName);
    on<LastNameChanged>(_onLastName);
    on<FirstNameBlurred>(_onFirstNameBlurred);
    on<LastNameBlurred>(_onLastNameBlurred);
    on<NameSubmitted>(_onNameSubmitted);
    on<BirthMonthChanged>(_onMonth);
    on<BirthDayChanged>(_onDay);
    on<BirthYearChanged>(_onYear);
    on<BirthBlurred>(_onBirthBlurred);
    on<BirthSubmitted>(_onBirthSubmitted);
    on<RegistrationBackPressed>(_onBack);
    on<SwitchToRegister>(_onSwitchToRegister);
    on<SwitchToSignIn>(_onSwitchToSignIn);
  }

  final AuthRepository _repository;
  final SignIn _signIn;
  final RegisterAccount _registerAccount;
  final SecondTicker _ticker;
  final AuthPacing _pacing;
  final DateTime Function() _clock;
  StreamSubscription<int>? _ticks;

  @override
  Future<void> close() {
    _ticks?.cancel();
    return super.close();
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    emit(
      state.copyWith(
        phoneRaw: event.value,
        unknownAccount: false,
        alreadyRegistered: false,
        unavailable: false,
      ),
    );
  }

  void _onPhoneBlurred(PhoneBlurred event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(phoneTouched: true));
  }

  Future<void> _onPhoneSubmitted(
    PhoneSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (!_begin(emit)) {
      return;
    }
    if (!state.phoneReady) {
      emit(
        state.copyWith(status: RegistrationStatus.editing, phoneTouched: true),
      );
      return;
    }
    final phone = validatePhone(state.phoneRaw) as ValidPhone;
    final found = await _repository.findByPhone(phone.e164);
    if (isClosed) {
      return;
    }
    switch (found) {
      case Failure():
        emit(
          state.copyWith(status: RegistrationStatus.editing, unavailable: true),
        );
      case Success(value: null):
        _missingAccount(emit);
      case Success():
        _knownAccount(emit);
    }
  }

  void _missingAccount(Emitter<RegistrationState> emit) {
    if (state.purpose == RegistrationPurpose.signIn) {
      emit(
        state.copyWith(
          status: RegistrationStatus.editing,
          unknownAccount: true,
          phoneTouched: true,
        ),
      );
      return;
    }
    _enterOtp(emit);
  }

  void _knownAccount(Emitter<RegistrationState> emit) {
    if (state.purpose == RegistrationPurpose.register) {
      emit(
        state.copyWith(
          status: RegistrationStatus.editing,
          alreadyRegistered: true,
          phoneTouched: true,
        ),
      );
      return;
    }
    _enterOtp(emit);
  }

  void _onOtpChanged(OtpChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting || state.otpLocked) {
      return;
    }
    final next = _digits(event.value);
    emit(state.copyWith(otp: next, clearOtpError: true));
    if (next.length == OtpRules.length) {
      add(const OtpSubmitted());
    }
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (!_begin(emit)) {
      return;
    }
    if (state.otpLocked || state.otp.length != OtpRules.length) {
      emit(state.copyWith(status: RegistrationStatus.editing));
      return;
    }
    if (state.purpose == RegistrationPurpose.signIn) {
      await _submitSignIn(emit);
      return;
    }
    await _submitRegisterOtp(emit);
  }

  Future<void> _submitRegisterOtp(Emitter<RegistrationState> emit) async {
    await Future<void>.delayed(_pacing.delay);
    if (isClosed) {
      return;
    }
    final check = validateOtp(
      code: state.otp,
      failedAttempts: state.failedAttempts,
    );
    if (check is OtpRejected) {
      _rejectOtp(emit, check);
      return;
    }
    _ticks?.cancel();
    emit(
      state.copyWith(
        status: RegistrationStatus.editing,
        step: RegistrationStep.name,
        clearOtpError: true,
      ),
    );
  }

  Future<void> _submitSignIn(Emitter<RegistrationState> emit) async {
    final result = await _signIn(
      phoneRaw: state.phoneRaw,
      code: state.otp,
      failedAttempts: state.failedAttempts,
    );
    if (isClosed) {
      return;
    }
    if (result case Failure(failure: final failure)) {
      _signInFailed(emit, failure);
      return;
    }
    final user = (result as Success<UserAccount>).value;
    _finish(emit, destination: AppRoutes.home, userId: user.phoneE164);
  }

  void _signInFailed(Emitter<RegistrationState> emit, AppFailure failure) {
    if (failure is InvalidOtpFailure) {
      _rejectOtp(
        emit,
        OtpRejected(
          reason: failure.reason,
          failedAttempts: failure.failedAttempts,
        ),
      );
      return;
    }
    emit(state.copyWith(status: RegistrationStatus.editing, unavailable: true));
  }

  void _rejectOtp(Emitter<RegistrationState> emit, OtpRejected check) {
    emit(
      state.copyWith(
        status: RegistrationStatus.editing,
        otp: '',
        failedAttempts: check.failedAttempts,
        otpError: check.reason,
        shake: state.shake + 1,
      ),
    );
  }

  void _onResend(ResendPressed event, Emitter<RegistrationState> emit) {
    if (state.submitting || state.resendRemaining > Duration.zero) {
      return;
    }
    emit(
      state.copyWith(
        failedAttempts: 0,
        otp: '',
        clearOtpError: true,
        resendRemaining: OtpRules.resendWait,
      ),
    );
    _armResend();
  }

  void _onTick(
    RegistrationCountdownTicked event,
    Emitter<RegistrationState> emit,
  ) {
    if (state.step != RegistrationStep.otp) {
      return;
    }
    emit(state.copyWith(resendRemaining: event.remaining));
  }

  void _onFirstName(FirstNameChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    emit(state.copyWith(firstName: event.value));
  }

  void _onLastName(LastNameChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    emit(state.copyWith(lastName: event.value));
  }

  void _onFirstNameBlurred(
    FirstNameBlurred event,
    Emitter<RegistrationState> emit,
  ) {
    emit(state.copyWith(firstNameTouched: true));
  }

  void _onLastNameBlurred(
    LastNameBlurred event,
    Emitter<RegistrationState> emit,
  ) {
    emit(state.copyWith(lastNameTouched: true));
  }

  Future<void> _onNameSubmitted(
    NameSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (!_begin(emit)) {
      return;
    }
    if (!state.nameReady) {
      emit(
        state.copyWith(
          status: RegistrationStatus.editing,
          firstNameTouched: true,
          lastNameTouched: true,
        ),
      );
      return;
    }
    await Future<void>.delayed(_pacing.delay);
    if (isClosed) {
      return;
    }
    emit(
      state.copyWith(
        status: RegistrationStatus.editing,
        step: RegistrationStep.birth,
      ),
    );
  }

  void _onMonth(BirthMonthChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    emit(state.copyWith(month: event.value));
  }

  void _onDay(BirthDayChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    emit(state.copyWith(day: event.value));
  }

  void _onYear(BirthYearChanged event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    emit(state.copyWith(year: event.value));
  }

  void _onBirthBlurred(BirthBlurred event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(birthTouched: true));
  }

  Future<void> _onBirthSubmitted(
    BirthSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (!_begin(emit)) {
      return;
    }
    if (!state.birthReady(_clock())) {
      emit(
        state.copyWith(status: RegistrationStatus.editing, birthTouched: true),
      );
      return;
    }
    final result = await _registerAccount(_registrationInput());
    if (isClosed) {
      return;
    }
    if (result case Failure(failure: final failure)) {
      _birthFailed(emit, failure);
      return;
    }
    final user = (result as Success<UserAccount>).value;
    _finish(emit, destination: AppRoutes.welcome, userId: user.phoneE164);
  }

  void _birthFailed(Emitter<RegistrationState> emit, AppFailure failure) {
    if (failure is AccountAlreadyExistsFailure) {
      emit(
        state.copyWith(
          status: RegistrationStatus.editing,
          step: RegistrationStep.phone,
          alreadyRegistered: true,
          phoneTouched: true,
        ),
      );
      return;
    }
    emit(state.copyWith(status: RegistrationStatus.editing, unavailable: true));
  }

  void _onBack(RegistrationBackPressed event, Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return;
    }
    final previous = _previous(state.step);
    if (previous == null) {
      return;
    }
    if (state.step == RegistrationStep.otp) {
      _ticks?.cancel();
    }
    emit(state.copyWith(step: previous, status: RegistrationStatus.editing));
    if (previous == RegistrationStep.otp) {
      _armResend(state.resendRemaining);
    }
  }

  void _onSwitchToRegister(
    SwitchToRegister event,
    Emitter<RegistrationState> emit,
  ) {
    if (state.submitting) {
      return;
    }
    emit(
      state.copyWith(
        purpose: RegistrationPurpose.register,
        unknownAccount: false,
      ),
    );
    _enterOtp(emit);
  }

  void _onSwitchToSignIn(
    SwitchToSignIn event,
    Emitter<RegistrationState> emit,
  ) {
    if (state.submitting) {
      return;
    }
    emit(
      state.copyWith(
        purpose: RegistrationPurpose.signIn,
        alreadyRegistered: false,
      ),
    );
    _enterOtp(emit);
  }

  bool _begin(Emitter<RegistrationState> emit) {
    if (state.submitting) {
      return false;
    }
    emit(
      state.copyWith(status: RegistrationStatus.submitting, unavailable: false),
    );
    return true;
  }

  void _enterOtp(Emitter<RegistrationState> emit) {
    emit(
      state.copyWith(
        status: RegistrationStatus.editing,
        step: RegistrationStep.otp,
        unknownAccount: false,
        alreadyRegistered: false,
        unavailable: false,
        resendRemaining: OtpRules.resendWait,
      ),
    );
    _armResend();
  }

  void _finish(
    Emitter<RegistrationState> emit, {
    required String destination,
    required String userId,
  }) {
    _ticks?.cancel();
    emit(
      state.copyWith(
        status: RegistrationStatus.editing,
        destination: destination,
        userId: userId,
      ),
    );
  }

  void _armResend([Duration? from]) {
    _ticks?.cancel();
    final seconds = (from ?? OtpRules.resendWait).inSeconds;
    if (seconds <= 0) {
      return;
    }
    _ticks = _ticker.countdown(seconds).listen((left) {
      add(RegistrationCountdownTicked(Duration(seconds: left)));
    });
  }

  RegisterAccountInput _registrationInput() {
    final date = (state.birthCheck(_clock()) as ValidBirthDate).date;
    return RegisterAccountInput(
      phoneRaw: state.phoneRaw,
      firstName: state.firstName,
      lastName: state.lastName,
      month: date.month,
      day: date.day,
      year: date.year,
    );
  }
}

RegistrationStep? _previous(RegistrationStep step) {
  return switch (step) {
    RegistrationStep.phone => null,
    RegistrationStep.otp => RegistrationStep.phone,
    RegistrationStep.name => RegistrationStep.otp,
    RegistrationStep.birth => RegistrationStep.name,
  };
}

String _digits(String value) {
  final digits = value.replaceAll(RegExp(r'\D'), '');
  if (digits.length <= OtpRules.length) {
    return digits;
  }
  return digits.substring(0, OtpRules.length);
}
