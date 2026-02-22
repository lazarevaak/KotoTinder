import 'package:flutter/material.dart';

import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/complete_onboarding.dart';
import '../../domain/usecases/init_auth.dart';

import '../../data/datasources/services/analytics_service.dart';

class AuthViewModel extends ChangeNotifier {
  final Login loginUseCase;
  final Register registerUseCase;
  final CompleteOnboarding completeOnboardingUseCase;
  final InitAuth initAuth;
  final AnalyticsService analytics; 

  bool isLoggedIn = false;
  bool onboardingCompleted = false;
  bool isInitialized = false;
  String? error;

  AuthViewModel({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.completeOnboardingUseCase,
    required this.initAuth,
    required this.analytics, 
  });

  Future<void> init() async {
    try {
      final result = await initAuth();
      isLoggedIn = result.isLoggedIn;
      onboardingCompleted = result.onboardingCompleted;
    } catch (e) {
      error = _mapError(e);
    }

    isInitialized = true;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      await loginUseCase(email, password);

      isLoggedIn = true;
      error = null;

      await analytics.logEvent('login_success');
    } catch (e) {
      error = _mapError(e);

      await analytics.logEvent(
        'login_error',
        parameters: {
          'message': error,
        },
      );
    }

    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    try {
      await registerUseCase(email, password);

      isLoggedIn = true;
      onboardingCompleted = false;
      error = null;

      await analytics.logEvent('register_success');
    } catch (e) {
      error = _mapError(e);

      await analytics.logEvent(
        'register_error',
        parameters: {
          'message': error,
        },
      );
    }

    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    try {
      await completeOnboardingUseCase();
      onboardingCompleted = true;
      error = null;

      await analytics.logEvent('onboarding_completed');
    } catch (e) {
      error = _mapError(e);
    }

    notifyListeners();
  }

  String _mapError(Object e) {
    final message = e.toString();

    if (message.startsWith('Exception: ')) {
      return message.replaceFirst('Exception: ', '');
    }

    return message;
  }
}