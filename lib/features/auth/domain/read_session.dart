import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';

/// Reads the user id saved for the next launch.
class ReadSession {
  const ReadSession(this._repository);

  final AuthRepository _repository;

  Future<Result<String?>> call() => _repository.readSession();
}
