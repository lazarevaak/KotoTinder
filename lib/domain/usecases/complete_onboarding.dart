import '../repositories/auth_repository.dart';

class CompleteOnboarding {
  final AuthRepository repository;

  CompleteOnboarding(this.repository);

  Future<void> call() async {
    await repository.completeOnboarding();
  }
}