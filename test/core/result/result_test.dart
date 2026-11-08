import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';

void main() {
  test('capture returns the value when the action succeeds', () async {
    final result = await Result.capture(() async => 2);

    expect(result, const Success<int>(2));
  });

  test('capture returns the typed failure thrown by the action', () async {
    final result = await Result.capture<int>(() async {
      throw const NetworkFailure();
    });

    expect(result, const Failure<int>(NetworkFailure()));
  });

  test('capture keeps the cause and stack trace of an unexpected error', () async {
    final result = await Result.capture<int>(() async {
      throw StateError('boom');
    });

    expect(result, isA<Failure<int>>());
    final failure = (result as Failure<int>).failure;
    expect(failure, isA<UnexpectedFailure>());
    final unexpected = failure as UnexpectedFailure;
    expect(unexpected.cause, isA<StateError>());
    expect(unexpected.cause.toString(), contains('boom'));
    expect(unexpected.stackTrace.toString(), isNotEmpty);
  });
}
