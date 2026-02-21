import '../repositories/auth/auth_repository.dart';

class CheckOnboardingStatus {
  final AuthRepository repository;

  CheckOnboardingStatus(this.repository);

  Future<bool> call() {
    return repository.isOnboardingCompleted();
  }
}