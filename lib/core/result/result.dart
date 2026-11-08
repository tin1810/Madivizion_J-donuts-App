import 'package:madivizion_jdonuts_app/core/error/app_failure.dart';

export 'package:madivizion_jdonuts_app/core/error/app_failure.dart';

/// The outcome of an operation that can fail in a typed way.
sealed class Result<T> {
  const Result();

  /// Runs [action] and returns its value, or the failure it produced.
  ///
  /// A known [AppFailure] is returned as-is. Any other throw is kept as an
  /// [UnexpectedFailure] with its stack trace.
  static Future<Result<T>> capture<T>(Future<T> Function() action) async {
    try {
      final value = await action();
      return Success(value);
    } on AppFailure catch (failure) {
      return Failure(failure);
    } catch (error, stackTrace) {
      return Failure(UnexpectedFailure(error, stackTrace));
    }
  }
}

/// [action] finished and produced [value].
final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  bool operator ==(Object other) {
    return other is Success<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// [action] failed with [failure].
final class Failure<T> extends Result<T> {
  const Failure(this.failure);

  final AppFailure failure;

  @override
  bool operator ==(Object other) {
    return other is Failure<T> && other.failure == failure;
  }

  @override
  int get hashCode => failure.hashCode;
}
