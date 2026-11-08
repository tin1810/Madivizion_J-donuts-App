/// A typed failure returned through [Result].
///
/// Feature failures extend this class. [Result.capture] records an unexpected
/// error without dropping its cause.
abstract class AppFailure {
  const AppFailure();
}

/// The device could not reach the network.
final class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

/// The local store could not be read or written.
final class CacheFailure extends AppFailure {
  const CacheFailure();
}

/// An error that was not a known [AppFailure].
final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;

  @override
  bool operator ==(Object other) {
    return other is UnexpectedFailure &&
        other.cause == cause &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => Object.hash(cause, stackTrace);
}
