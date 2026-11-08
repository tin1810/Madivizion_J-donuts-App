import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/app/di/app_bloc_observer.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';

void main() {
  tearDown(() async {
    await injector.reset();
  });

  test('configureDependencies registers one shared bloc observer', () async {
    await configureDependencies();

    final first = injector<BlocObserver>();
    final second = injector<BlocObserver>();

    expect(first, isA<AppBlocObserver>());
    expect(identical(first, second), isTrue);
  });
}
