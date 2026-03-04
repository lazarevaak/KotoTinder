import 'auth_repository.dart';
import '../../../data/datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.local);

  @override
  Future<void> register(String email, String password) async {
    await local.saveCredentials(email, password);
  }

  @override
  Future<void> login(String email, String password) async {
    final valid = await local.validateCredentials(email, password);
    if (!valid) {
      throw Exception("Invalid credentials");
    }
    await local.setLoggedIn(true);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await local.hasActiveSession();
  }

  @override
  Future<void> logout() async {
    await local.setLoggedIn(false);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return local.isOnboardingCompleted();
  }

  @override
  Future<void> completeOnboarding() async {
    await local.completeOnboarding();
  }
}
