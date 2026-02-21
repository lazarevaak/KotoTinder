import 'check_auth_status.dart';
import 'check_onboarding_status.dart';

class InitAuthResult {
  final bool isLoggedIn;
  final bool onboardingCompleted;

  InitAuthResult({
    required this.isLoggedIn,
    required this.onboardingCompleted,
  });
}

class InitAuth {
  final CheckAuthStatus checkAuthStatus;
  final CheckOnboardingStatus checkOnboardingStatus;

  InitAuth(
    this.checkAuthStatus,
    this.checkOnboardingStatus,
  );

  Future<InitAuthResult> call() async {
    final loggedIn = await checkAuthStatus();
    final onboarding = await checkOnboardingStatus();

    return InitAuthResult(
      isLoggedIn: loggedIn,
      onboardingCompleted: onboarding,
    );
  }
}