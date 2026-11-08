import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_timing.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/register_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/sign_in.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_bloc.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_page.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/registration_state.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/registration/second_ticker.dart';

/// Creates one [RegistrationBloc] for a register or sign-in entry.
class RegistrationFlow extends StatelessWidget {
  const RegistrationFlow({required this.purpose, super.key});

  final RegistrationPurpose purpose;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(
        purpose: purpose,
        repository: injector<AuthRepository>(),
        signIn: injector<SignIn>(),
        registerAccount: injector<RegisterAccount>(),
        ticker: injector<SecondTicker>(),
        pacing: injector<AuthPacing>(),
      ),
      child: const RegistrationPage(),
    );
  }
}
