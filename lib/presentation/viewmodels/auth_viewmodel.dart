import 'package:flutter/material.dart';

import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/complete_onboarding.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final Login loginUseCase;
  final Register registerUseCase;
  final CheckAuthStatus checkAuthStatus;
  final CompleteOnboarding completeOnboardingUseCase;
  final AuthRepository repository;

  bool isLoggedIn = false;
  bool onboardingCompleted = false;
  bool isInitialized = false;
  String? error;

  AuthViewModel({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.checkAuthStatus,
    required this.completeOnboardingUseCase,
    required this.repository,
  });

  Future<void> init() async {
    isLoggedIn = await checkAuthStatus();
    onboardingCompleted = await repository.isOnboardingCompleted();

    isInitialized = true;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      await loginUseCase(email, password);
      isLoggedIn = true;
      error = null;
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    await registerUseCase(email, password);

    isLoggedIn = true;
    onboardingCompleted = false; 

    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await completeOnboardingUseCase();
    onboardingCompleted = true;
    notifyListeners();
  }
}
