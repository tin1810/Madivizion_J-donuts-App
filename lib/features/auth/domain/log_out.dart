import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/core/result/unit.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';

/// Clears the saved session.
class LogOut {
  const LogOut(this._repository);

  final AuthRepository _repository;

  Future<Result<Unit>> call() => _repository.clearSession();
}
